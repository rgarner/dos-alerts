require 'yaml'
require 'active_record'

module DOS
  ##
  # Configure our database on a notional ENV environment ('test', 'development', 'production')
  module DB
    def self.configure
      # rubocop:disable Security/YAMLLoad we're genuinely using references
      ActiveRecord::Base.configurations = YAML.load(
        File.read(File.join(DOS.root, 'db/config.yml'))
      )
      # rubocop:enable Security/YAMLLoad
      ActiveRecord::Base.establish_connection ENV['ENV']&.to_sym || :development
    end
  end
end
