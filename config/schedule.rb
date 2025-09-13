env :PATH, ENV["PATH"]

set :output, "#{path}/log/cron.log"

# Define a daily job to update the UF value.
# The job will run at 1:00 AM every day.
every 1.day, at: "1:00 am" do
  rake "uf:update"
end
