require 'dos'

namespace :dos do
  desc "Rescrape things we've already seen to backfill attrs we didn't have then"
  task :rescrape do
    require 'mechanize'

    agent = Mechanize.new

    ::Opportunity.all.each do |opportunity|
      response = agent.get(opportunity.original_url)
      scraped = DOS::Opportunity.new(response, opportunity.original_url)
      relevant_attrs = DOS::Opportunity::ATTRIBUTES - %i[id url]
      opportunity.update_attributes!(scraped.to_h.slice(*relevant_attrs))
    end
  end

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
      opps = ::Opportunity.all.map do |opportunity|
        formatted = ::Opportunity::Formatter.new(opportunity).to_s
        formatted.sub! %r{https://.*$}, 'https://t.co/0123456789'
        { length: formatted.length, body: formatted }
      end

      opps.sort { |a, b| a[:length] > b[:length] ? 1 : -1 }.each do |opp|
        puts "**************************************************(#{opp[:length]})"
        puts opp[:body]
      end
    end
  end
end
