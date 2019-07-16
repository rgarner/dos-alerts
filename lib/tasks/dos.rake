namespace :dos do
  desc 'Scrape the DOS site and save results locally'
  task :scrape do
    require 'dos'

    DOS::Spider.new.each_opportunity do |_spider, opportunity|
      new_opportunity = ::Opportunity.from_scraped(opportunity)
      new_opportunity.save!
    end
  end
end