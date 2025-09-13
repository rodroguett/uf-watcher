namespace :uf do
  desc "Update the daily UF value from the CMF API"
  task update: :environment do
    puts "Starting daily UF update..."
    UfUpdaterService.call
    puts "Daily UF update finished."
  end
end
