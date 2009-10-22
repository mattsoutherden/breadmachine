module BreadMachine
  module SecureTrading

    # A response object which tells us what happened with a 3-D Secure
    # AUTH request.
    #
    class St3dAuthResponse < XpayResponse

      # Returns true if the AUTH request was successful, i.e. if the funds were
      # successfully reserved.
      #
      def successful?
        @xml.xpath('//OperationResponse/Result').text == "1"
      end
      
      def declined?
        @xml.xpath('//OperationResponse/Result').text == "2"
      end

      # A unique identifier for this AUTH transaction.
      #
      def transaction_reference
        @xml.xpath('//OperationResponse/TransactionReference').text
      end

      def transaction_verifier
        @xml.xpath('//OperationResponse/TransactionVerifier').text
      end

    end

  end
end

