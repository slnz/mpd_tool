desc 'This task is called by the Heroku scheduler add-on'
task fetch_donations: :environment do
    puts 'Fetching donations...'
    Donation::Fetch.from_dataserve
    puts 'done.'
end
