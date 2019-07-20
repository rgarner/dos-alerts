$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:rubocop) do |t|
    t.options = ['--display-cop-names']
  end
rescue LoadError
end

task default: %i[spec rubocop]

require 'standalone_migrations'
# No require for 'our' tasks as this calls Rails::Engine#load_task_blocks, which
# automatically loads everything in lib/tasks. If we try to load them again
# tasks will run twice.
StandaloneMigrations::Tasks.load_tasks
