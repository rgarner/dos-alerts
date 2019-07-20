require 'oauth'

namespace :twitter do
  desc 'Sign in on behalf of @dosalerts to receive a token and secret usable ' \
       'in env vars. Requires that you paste an oauth_verifier from a URL'
  task :sign_in do
    callback_url = 'https://127.0.0.1:4567/auth/twitter'

    oauth_consumer = OAuth::Consumer.new(
      ENV['DOS_CONSUMER_KEY'] || raise('DOS_CONSUMER_KEY required from dev account'),
      ENV['DOS_CONSUMER_SECRET'] || raise('DOS_CONSUMER_SECRET required from dev account'),
      site: 'https://api.twitter.com',
      request_token_path: '/oauth/request_token',
      authorize_path: '/oauth/authorize',
      access_token_path: '/oauth/access_token'
    )

    request_token = oauth_consumer.get_request_token(oauth_callback: callback_url)

    authorize_url = request_token.authorize_url(oauth_callback: callback_url)
    puts "Please authorize #{authorize_url} " \
         'as the @dosalerts user. It will redirect to a local URL with a verifier key'

    puts 'Paste your verifier and hit RETURN:'
    verifier = STDIN.gets.chomp

    hash = { oauth_token: request_token.token, oauth_token_secret: request_token.secret }
    request_token = OAuth::RequestToken.from_hash(oauth_consumer, hash)
    access_token  = request_token.get_access_token oauth_verifier: verifier

    puts "DOS_ALERTS_TOKEN=#{access_token.token}"
    puts "DOS_ALERTS_SECRET=#{access_token.secret}"
  end

  desc 'Post an example tweet to @dosalerts'
  task :post_example do
    require 'twitter'

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['DOS_CONSUMER_KEY']
      config.consumer_secret     = ENV['DOS_CONSUMER_SECRET']
      config.access_token        = ENV['DOS_ALERTS_TOKEN']
      config.access_token_secret = ENV['DOS_ALERTS_SECRET']
    end

    client.update("I'm tweeting with @gem!")
  end
end
