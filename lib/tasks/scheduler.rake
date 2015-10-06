desc 'This task is called by the Heroku scheduler add-on'
task update_donations: :environment do
  puts 'Updating donations...'
  Donation::Fetch.from_dataserve
  puts 'done.'
end
