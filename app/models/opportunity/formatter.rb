class Opportunity
  ##
  # Format an opportunity for Twitter
  class Formatter
    attr_reader :opportunity
    def initialize(opportunity)
      @opportunity = opportunity
    end

    ABBREVIATED_TYPES = {
      'Digital outcomes' => 'Outcomes',
      'Digital specialists' => 'Specialists',
      'User research participants' => 'Research'
    }.freeze

    def to_s
      <<~TEXT
        #{ABBREVIATED_TYPES.fetch(opportunity.type)}
        #{opportunity.buyer}
        #{opportunity.title}

        #{opportunity.location}
        #{opportunity.original_url}
      TEXT
    end
  end
end
