$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'standalone_migrations'
# No require for our tasks as this somehow also loads them (!)
StandaloneMigrations::Tasks.load_tasks

