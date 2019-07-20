$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

# rubocop:disable Lint/HandleExceptions this is the recommended way to load RSpec
begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end
# rubocop:enable Lint/HandleExceptions

require 'rubocop/rake_task'

RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = ['--display-cop-names']
end

task default: %i[spec rubocop]

require 'standalone_migrations'
# No require for 'our' tasks as this calls Rails::Engine#load_task_blocks, which
# automatically loads everything in lib/tasks. If we try to load them again
# tasks will run twice.
StandaloneMigrations::Tasks.load_tasks
