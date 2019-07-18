ENV['ENV'] = 'test'

require 'rspec'
require 'vcr'
require 'dos'

Dir[File.join(DOS.root, 'spec', 'support', '**', '*.rb')].each(&method(:require))

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end