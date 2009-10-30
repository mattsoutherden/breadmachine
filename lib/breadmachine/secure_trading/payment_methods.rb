module BreadMachine
  module SecureTrading

    module PaymentMethods

      def auth(*args)
        request = SecureTrading::AuthRequest.new(*args)
        return SecureTrading::XPay.exchange(request)
      end

      def moto_auth(*args)
        request = SecureTrading::MotoAuthRequest.new(*args)
        return SecureTrading::XPay.exchange(request)
      end
      
      # Checks to see whether a card is enrolled in 3-D Secure. Returns a
      # ST3DCardQueryResponse which can tell us whether the card is enrolled
      # and what kind of authorisation to perform.
      #
      # Arguments are: amount, creditcard, customer_info, order_info
      #
      def three_d_secure_enrolled?(*args)
        request = SecureTrading::St3dCardQueryRequest.new(*args)
        return SecureTrading::XPay.exchange(request)
      end

      def three_d_auth(*args)
        request = SecureTrading::St3dAuthRequest.new(*args)
        return SecureTrading::XPay.exchange(request)
      end

      def reverse(*args)
        request = SecureTrading::AuthReversalRequest.new(*args)
        return SecureTrading::XPay.exchange(request)
      end
    end

  end
end

