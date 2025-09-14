class UfController < ApplicationController
  def index
    today_date = Date.today.strftime("%Y-%m-%d")

    # Use cache for today's UF value
    @uf_value = Rails.cache.fetch("uf_value_#{today_date}", expires_in: 1.day) do
      UfValue.find_by(date: Date.today)
    end
  end

  def show
    date = params[:date]

    if date.blank?
      flash.now[:alert] = "La fecha no puede estar vacía."
      render :index
      return
    end

    begin
      search_date = Date.parse(date)

      # Use cache for the selected date
      cache_key = "uf_value_#{search_date}"
      @uf_value = Rails.cache.fetch(cache_key, expires_in: 1.day) do
        UfValue.find_by(date: search_date)
      end

    rescue ArgumentError
      flash.now[:alert] = "Formato de fecha inválido. Por favor, usa YYYY-MM-DD."
    end
    render :index
  end
end
