module BreadMachine
  module SecureTrading
    
    class XpayResponse
      
      def initialize(xml)
        @xml = Nokogiri::XML.parse(xml)
      end
      
      # Checks whether there has been an error somewhere in the chain of servers
      # which are processing your request (for example, if Visa's server cacked,
      # or XPay had an internal error, this would come back as true).
      #
      def error?
        result == '0'
      end
      
      def result
        @xml.xpath('//OperationResponse/Result').text
      end
      
      def message
        @xml.xpath('//OperationResponse/Message').text
      end
      
    end
    
  end
end