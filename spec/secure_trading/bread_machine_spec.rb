require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BreadMachine do
  
  describe "performing a 3-D secure card enrollment check" do
    
    it "should build a card query request" do
      card = BreadMachine::Card.make
      BreadMachine::SecureTrading::St3dCardQueryRequest.should_receive(:new).with(card)
      BreadMachine::SecureTrading::XPay.stub(:exchange)
      BreadMachine.three_d_secure_enrolled?(card)
    end
    
  end
  
end