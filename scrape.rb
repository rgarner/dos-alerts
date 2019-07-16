#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
puts $LOAD_PATH

require 'kimurai'
require 'dos/spider'

DOS::Spider.new.each_opportunity do |spider, opportunity|
  spider.save_to 'results.json', opportunity.to_h, format: :pretty_json
end