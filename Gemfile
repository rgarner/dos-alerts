source 'https://rubygems.org' do
  ruby '2.6.3'

  gem 'activerecord'
  gem 'dotenv'
  gem 'kimurai'
  gem 'oauth' # for rake twitter:sign_in only, but does need to be available in production
  gem 'pg'
  gem 'rake'
  gem 'standalone_migrations'
  gem 'twitter'

  group :development, :test do
    gem 'rubocop'
  end

  group :test do
    gem 'database_cleaner'
    gem 'factory_bot'
    gem 'rspec'
    gem 'rspec_junit_formatter' # for CircleCI
    gem 'vcr'
    gem 'webmock'
  end
end
