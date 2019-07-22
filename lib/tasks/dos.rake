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
