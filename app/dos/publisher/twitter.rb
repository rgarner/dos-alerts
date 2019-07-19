require 'twitter'
require 'opportunity/formatter'

module DOS
  module Publisher
    ##
    # Publish an opportunity to Twitter
    class Twitter
      def initialize
        Dotenv.require_keys(
          'DOS_CONSUMER_KEY',
          'DOS_CONSUMER_SECRET',
          'DOS_ALERTS_TOKEN',
          'DOS_ALERTS_SECRET'
        )
      end

      def publish(opportunity)
        summary = ::Opportunity::Formatter.new(opportunity).to_s
        client.update summary
        opportunity.mark_published!
      end

      def client
        @client ||= ::Twitter::REST::Client.new do |config|
          config.consumer_key        = ENV['DOS_CONSUMER_KEY']
          config.consumer_secret     = ENV['DOS_CONSUMER_SECRET']
          config.access_token        = ENV['DOS_ALERTS_TOKEN']
          config.access_token_secret = ENV['DOS_ALERTS_SECRET']
        end
      end
    end
  end
end