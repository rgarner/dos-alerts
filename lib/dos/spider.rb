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
      user_agent: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36',
    }

    def parse(response, url:, data: {})
      response.css('.search-result a').each do |a|
        request_to :parse_opportunity, url: absolute_url(a[:href], base: url)
      end

      next_page = response.at_css('li.next a')
      request_to :parse, url: absolute_url(next_page[:href], base: url) if next_page
    end

    def parse_opportunity(response, url:, data: {})
      opportunity = Opportunity.new(response, url)

      self.class.config[:on_opportunity].call(self, opportunity)
    end

    def each_opportunity(&block)
      self.class.config[:on_opportunity] = block

      self.class.crawl!
    end

    # Overrides Kimurai::Base.config, which has a base class check and is empty if we don't
    class << self
      attr_reader :config
    end
  end
end