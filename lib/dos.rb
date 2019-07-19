module DOS
  def self.root
    File.join(File.dirname(__FILE__), '..')
  end
end

$LOAD_PATH.unshift(File.join(DOS.root, 'app'))
$LOAD_PATH.unshift(File.join(DOS.root, 'app', 'models'))

require 'dotenv/load'
require 'dos/db'
require 'dos/spider'
require 'dos/alerter'
require 'opportunity'
require 'dos/publisher/console'
require 'dos/publisher/twitter'

DOS::DB.configure