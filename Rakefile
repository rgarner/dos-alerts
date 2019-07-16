$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'standalone_migrations'
StandaloneMigrations::Tasks.load_tasks

Dir.glob('lib/tasks/*.rake').each(&method(:load))

