require 'dos/spider'

module DOS
  ##
  # Given a publisher that responds to #publish(opportunity),
  # spider open opportunities, spot the differences, and call
  # the publisher for each opportunity we haven't already published
  class Alerter
    attr_reader :publisher

    def initialize(publisher)
      @publisher = publisher
    end

    def spider
      @spider ||= DOS::Spider.new
    end

    def run
      spider.each_opportunity do |_spider, scraped_opportunity|
        saved_opportunity = find_or_persist(scraped_opportunity)
        publisher.publish(saved_opportunity) unless saved_opportunity&.published?
      end
    end

    private

    def find_or_persist(scraped_opportunity)
      ::Opportunity.find_by(original_id: scraped_opportunity.id) ||
        ::Opportunity.from_scraped(scraped_opportunity).tap(&:save!)
    end
  end
end
