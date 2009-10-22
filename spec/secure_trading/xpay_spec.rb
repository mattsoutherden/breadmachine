require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BreadMachine::SecureTrading::XPay do
  
  it "should retry socket exchange 3 times when a connection error occurs" do
    request = stub('request')
    request.stub(:to_xml => '<nothingtoseehere>')
    BreadMachine::SecureTrading::XPaySocket.should_receive(:open).exactly(3).times.and_raise(BreadMachine::GatewayConnectionError)
    lambda {
      BreadMachine::SecureTrading::XPay.exchange(request)
    }.should raise_error(BreadMachine::GatewayConnectionError)
  end
  
  it "should not retry for other errors" do
    request = stub('request')
    request.stub(:to_xml => '<nothingtoseehere>')
    request.stub(:response)
    BreadMachine::SecureTrading::XPaySocket.stub(:open)
    xpay = BreadMachine::SecureTrading::XPay.new
    xpay.should_receive(:handle_errors).once.and_raise(BreadMachine::MerchantConfigurationError)
    lambda {
      xpay.exchange(request)
    }.should raise_error(BreadMachine::MerchantConfigurationError)
  end
  
end