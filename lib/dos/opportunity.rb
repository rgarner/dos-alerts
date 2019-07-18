module DOS
  ##
  # How to parse an Opportunity from a response
  class Opportunity
    attr_reader :response, :original_url

    ATTRIBUTES = %i[
      id
      url
      title
      buyer
      location
      published
      question_deadline
      closing
      description
      expected_start_date
    ].freeze

    ATTRIBUTES.each do |attr|
      define_method attr do
        to_h[attr]
      end
    end

    def initialize(response, original_url = nil)
      @response = response
      @original_url = original_url
    end

    def text_from_label(label)
      find_by_label(label)&.text&.strip
    end

    def date_from_label(label)
      date_text = text_from_label(label)
      Date.parse(date_text) if date_text
    end

    def find_by_label(label)
      selector = "//td[@class='summary-item-field-first']/span[text()='#{label}']/../../td[@class='summary-item-field']"
      response.at_xpath(selector)
    end

    def to_h
      @to_h ||= {
        id: @original_url.split('/').last.to_i,
        url: @original_url,
        title: response.xpath('//header/h1').text,
        published: date_from_label('Published'),
        buyer: response.at('.context').text,
        location: text_from_label('Location'),
        question_deadline: date_from_label('Deadline for asking questions'),
        closing: date_from_label('Closing date for applications'),
        expected_start_date: date_from_label('Latest start date'),
        description: text_from_label('Summary of the work')
      }
    end
  end
end
