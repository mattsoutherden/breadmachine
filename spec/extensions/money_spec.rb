require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Money do
  
  describe "sterling" do
    
    it "should create Money (if only!)" do
      tenner = Money.sterling(10_00)
      tenner.should be_instance_of(Money)
    end
  
    it "should create new Money with currency of GBP" do
      tenner = Money.sterling(10_00)
      tenner.currency.should == "GBP"
    end
    
    it "should create Money with correct value" do
      tenner = Money.sterling(10_00)
      tenner.cents.should == 1000
    end
  
  end
  
end