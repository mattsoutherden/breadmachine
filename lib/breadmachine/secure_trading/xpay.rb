module BreadMachine
  module SecureTrading

    class XPay

      # A class method which wraps the individual request block with the
      # necessary xml for the XPay gateway.  Once the request is wrapped, this
      # method writes it to the Xpay client and returns the response.
      #
      def self.exchange(request)
        xpay = self.new
        xpay.exchange(request)
      end
      
      def exchange(request, retries = 3)
        request_xml = generate_xml(request)
        begin
          response_xml = exchange_with_xpay_client(request_xml)
          response = request.response(response_xml)
          handle_errors(response)
          return response
        rescue BreadMachine::GatewayConnectionError
          retry unless (retries -= 1) == 0
          raise
        end
      end
      
      protected
      
      def generate_xml(request)
        request = BreadMachine::SecureTrading::Request.new(request)
        request.to_xml
      end
      
      def exchange_with_xpay_client(request_xml)
        XPaySocket.open("localhost", 5000) do |socket|
          socket.write request_xml
          socket.read
        end
      end
      
      # Error codes from Xpay API documentation
      #
      # 100   Timeout reading from socket:
      #       ST Xpay did not receive the full XML in the given time from your
      #       application.
      # 
      # 101   Error reading from socket:
      #       ST Xpay did not receive a correct connection request from your
      #       application.
      # 
      # 1000  Failed to connect to a payment gateway:
      #       The ST Xpay client was unable to find a payment gateway.
      # 
      # 1100  Failed to receive from payment gateway:
      #       ST Xpay did not receive any response from the payment gateway.
      # 
      # 2100  Missing SiteReference or Certificate tag:
      #       The XML ST Xpay received was missing the site reference and/or 
      #       your secure ST Xpay certificate.
      #
      # 2500  [Various messages - One of the fields contains an invalid value]:
      #       The information returned contains the field name that was omitted 
      #       from the request or contained incorrect information.
      #
      # 3000  Gateway error:
      #       A SecureTrading payment gateway failed to receive a full ST Xpay
      #       request.
      #
      # 3010  Transaction Not Received Successfully:
      #       A SecureTrading payment gateway obtained the request but failed to
      #       decrypt it.
      #
      # 3100  Error with transaction details:
      #       The data retrieved was incorrectly defined.
      #
      # 3100  Error in XML: Unknown Transaction Type:
      #       The Request Type attribute was incorrect.
      #
      # 3100  Error Parsing XML (invalid site reference for this certificate):
      #       The certificate included in the XML request is invalid for the
      #       SecureTrading sitereference included in the XML.
      #
      # 3100  Gateway Connection Error:
      #       The data obtained by ST Xpay was incorrect.
      #
      # 3100  Error parsing XML: [+reason]
      #       The gateway obtained invalid XML.
      #
      # 3100  Invalid Merchant Configuration:
      #       Merchant data on the gateway is inconsistent with merchant
      #       information in the XML (For example. invalid currency,
      #       payment type, etc).
      #
      # 3330  Transaction storage failure. Please try again later:
      #       Gateway failed to store the transaction details before
      #       authorisation.
      #
      # 3350  Transaction acceptance failure. Please try again later: 
      #       Gateway failed to update the transaction details after performing
      #       the authorisation.
      # 
      # 5000  Transport Error:
      #       Failed to connect to acquiring bank or the acquiring bank did not
      #       respond.
      #
      # 5100  Missing TransactionReference:
      #       The transaction cannot be found in the database.
      # 
      # 10500 Various Message:
      #       Xpay4 was unable to process your request.
      #
      def handle_errors(response)
        if response.error?
          message = response.message
          case message.match(/\((\d+)\)/)[1].to_i
            when 100, 101, 1000, 1100, 3000, 3010, 3330, 3350, 5000 then
              raise BreadMachine::GatewayConnectionError.new(message)
            when 2100, 3100 then
              raise BreadMachine::MerchantConfigurationError.new(message)
            when 2500, 5100, 10500 then
              raise BreadMachine::MerchantRequestError.new(message)
          end
        end
      end
      
    end

  end
end

