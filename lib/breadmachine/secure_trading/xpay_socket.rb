module BreadMachine
  module SecureTrading
    
    # This currently just delegates to TCPSocket, but this is where we will
    # inject Fake Socket behaviour to disconnect from having the XPay
    # client running during testing

    class XPaySocket
      
      class << self
        
        def open(*args, &block)
          begin
            return TCPSocket.open(*args, &block)
          rescue Errno::ECONNREFUSED
            raise BreadMachine::GatewayConnectionError
          end
        end
        
      end
      
    end
    
  end
end

