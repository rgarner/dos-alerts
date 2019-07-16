module DOS
  def self.root
    File.join(File.dirname(__FILE__), '..')
  end
end

$LOAD_PATH.unshift(File.join(DOS.root, 'app', 'models'))

require 'dos/db'
require 'dos/spider'
require 'opportunity'

DOS::DB.configure