require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BreadMachine::SecureTrading::XPaySocket do
  
  it "should open TCPSocket connection with correct host" do
    TCPSocket.should_receive(:open).with("localhost", 5000)
    BreadMachine::SecureTrading::XPaySocket.open("localhost", 5000)
  end
  
  it "should forward block to the socket" do
    mock_socket = mock('socket')
    mock_socket.should_receive(:method)
    TCPSocket.stub(:open).and_yield(mock_socket)
    
    BreadMachine::SecureTrading::XPaySocket.open("localhost", 5000) do |socket|
      socket.method
    end
  end
  
  it "should raise a BreadMachine error when failing to connect to the gateway" do
    TCPSocket.stub(:open).and_raise(Errno::ECONNREFUSED)
    lambda {
      BreadMachine::SecureTrading::XPaySocket.open("localhost", 5000)
    }.should raise_error(BreadMachine::GatewayConnectionError)
  end
  
end