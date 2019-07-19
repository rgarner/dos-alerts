source 'https://rubygems.org' do
  ruby '2.6.3'

  gem 'activerecord'
  gem 'dotenv'
  gem 'kimurai'
  gem 'pg'
  gem 'rake'
  gem 'standalone_migrations'
  gem 'twitter'

  group :development do
    gem 'oauth' # for rake twitter:sign_in only
  end

  group :test do
    gem 'rspec'
    gem 'vcr'
    gem 'webmock'
    gem 'database_cleaner'
  end
end