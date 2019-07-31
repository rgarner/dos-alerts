require 'kimurai'
require 'dos/opportunity'

module DOS
  ##
  # Spider open opportunities
  class Spider < Kimurai::Base
    OPEN_OPPORTUNITIES =
      'https://www.digitalmarketplace.service.gov.uk/digital-outcomes-and-specialists/opportunities'\
      '?q=&statusOpenClosed=open'.freeze

    @name = 'opportunities_spider'

    @start_urls = [OPEN_OPPORTUNITIES]
    @config = {
      user_agent: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) '\
                  'Chrome/68.0.3440.84 Safari/537.36'
    }

    def parse(response, url:, data: {})
      response.css('.search-result a').each do |a|
        opportunity_url = absolute_url(a[:href], base: url)
        already_seen = ::Opportunity.exists?(original_url: opportunity_url)
        request_to :parse_opportunity, url: opportunity_url unless already_seen
      end

      next_page = response.at_css('li.next a')
      request_to :parse, url: absolute_url(next_page[:href], base: url) if next_page
    end

    def parse_opportunity(response, url:, data: {})
      opportunity = Opportunity.new(response, url)

      self.class.on_opportunity.call(self, opportunity)
    end

    def each_opportunity(&block)
      raise LocalJumpError unless block_given?

      self.class.on_opportunity = block

      self.class.crawl!
    end

    class << self
      attr_accessor :on_opportunity
    end
  end
end
