require 'dos'

namespace :dos do
  desc 'Scrape the DOS site and save results locally'
  task :scrape do
    DOS::Spider.new.each_opportunity do |_spider, opportunity|
      if ::Opportunity.exists?(original_id: opportunity.id)
        warn "Seen #{opportunity.id}, skipping"
        next
      end

      new_opportunity = ::Opportunity.from_scraped(opportunity)
      new_opportunity.save!
    end
  end

  namespace :publish do
    desc 'Alert only new tasks'
    task :new do
      DOS::Alerter.new(DOS::Publisher::Twitter.new).run
    end

    desc 'Show summaries'
    task :summaries do
      ::Opportunity.all.each do |opportunity|
        formatted = ::Opportunity::Formatter.new(opportunity).to_s
        puts "********************************************(#{formatted.length})*****\n\n#{formatted}\n"
      end
    end
  end
end