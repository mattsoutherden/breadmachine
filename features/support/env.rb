$:.unshift File.expand_path(File.dirname(__FILE__) + '/../../lib')
require 'breadmachine'

require 'ostruct'

require 'rest_client'
require 'nokogiri'

require 'spec/blueprints'

BreadMachine::SecureTrading.configure do |config|
  config.currency = 'GBP'
  config.site_reference = 'testhubbub13583'
  config.term_url = 'http://www.example.com'
  config.merchant_name = "Hubbub"
end

module BreadMachineWorld
  attr_accessor :response
  attr_accessor :three_d_credentials
end

World(BreadMachineWorld)