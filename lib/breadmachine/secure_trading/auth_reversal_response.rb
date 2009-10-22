module BreadMachine
  module SecureTrading
    class AuthReversalResponse < XpayResponse
      
      def successful?
        self.result == '1'
      end
      
    end
  end
end