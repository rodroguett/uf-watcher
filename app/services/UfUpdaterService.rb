require "net/http"
require "json"

class UfUpdaterService
  def self.call
    new.update_uf
  end

  def update_uf
    api_key = ENV["CMF_API_KEY"]
    return log_error("CMF_API_KEY not found in environment variables.") unless api_key

    # Get the current date in YYYY/MM format
    current_date = Date.today.strftime("%Y/%m")
    uri = URI("https://api.sbif.cl/api-sbifv3/recursos_api/uf?apikey=#{api_key}&formato=json")

    log_info("Fetching UF value for today...")

    # Try fetching the data from the API
    response = fetch_data_with_retry(uri)

    return unless response

    parsed_response = JSON.parse(response.body)

    uf_data = parsed_response["UFs"].first

    if uf_data && uf_data["Valor"]
      uf_value = uf_data["Valor"].gsub(".", "").gsub(",", ".").to_f
      uf_date = Date.parse(uf_data["Fecha"])

      UfValue.find_or_create_by(date: uf_date) do |uf|
        uf.value = uf_value
      end

      # Invalidate the cache after updating the database to ensure data is consistent
      Rails.cache.delete("uf_value_#{uf_date}")

      log_info("UF value for #{uf_date} updated successfully and cache invalidated: $#{uf_value}.")
    else
      log_error("Could not find UF value in the API response.")
    end

  rescue StandardError => e
    log_error("An error occurred during UF update: #{e.message}")
  end

  private

  def fetch_data_with_retry(uri, retries = 3)
    response = nil
    begin
      response = Net::HTTP.get_response(uri)
      unless response.is_a?(Net::HTTPSuccess)
        raise "API request failed with status code #{response.code}: #{response.message}"
      end
    rescue => e
      log_error("Failed to fetch data from API: #{e.message}. Retrying...")
      retries -= 1
      retry if retries > 0
      log_error("Max retries reached. Giving up.")
      return nil
    end
    response
  end

  def log_info(message)
    Rails.logger.info("[UF UPDATE] #{message}")
  end

  def log_error(message)
    Rails.logger.error("[UF UPDATE] #{message}")
  end
end
