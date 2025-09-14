env :PATH, ENV["PATH"]

set :output, "#{path}/log/cron.log"

# Define a daily job to update the UF value.
# The job will run at server time 12:00 PM every day. (9:00 AM in Chile)

every 1.day, at: "12:00 pm" do
  rake "uf:update"
end

