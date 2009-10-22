require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BreadMachine::SecureTrading::Config do
  
  it "should set config from block" do
    BreadMachine::SecureTrading.configure do |config|
      config.currency = 'USD'
    end
    BreadMachine::SecureTrading.configuration.currency.should == 'USD'
  end
  
end