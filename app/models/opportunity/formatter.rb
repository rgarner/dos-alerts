class Opportunity
  ##
  # Format an opportunity for Twitter
  class Formatter
    attr_reader :opportunity
    def initialize(opportunity)
      @opportunity = opportunity
    end

    def to_s
      <<~TEXT
        #{opportunity.buyer}
        #{opportunity.title}

        #{opportunity.location}
        #{opportunity.original_url}
      TEXT
    end
  end
end
