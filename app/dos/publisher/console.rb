require 'opportunity/formatter'

module DOS
  module Publisher
    ##
    # Publish an opportunity to STDOUT
    class Console
      def publish(opportunity, output: STDOUT)
        summary = ::Opportunity::Formatter.new(opportunity).to_s
        output.puts summary
        opportunity.mark_published!
      end
    end
  end
end