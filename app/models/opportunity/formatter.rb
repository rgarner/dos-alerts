class Opportunity
  ##
  # Format an opportunity for Twitter
  class Formatter
    attr_reader :opportunity
    def initialize(opportunity)
      @opportunity = opportunity
    end

    ABBREVIATED_TYPES = {
      'Digital outcomes' => '#DOSOutcomes',
      'Digital specialists' => '#DOSSpecialists',
      'User research participants' => '#DOSResearch'
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
