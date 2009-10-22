module BreadMachine
  module SecureTrading
    
    class ThreeDSecureCredentialsXml
      
      def initialize(credentials)
        @credentials = credentials
      end
      
      def to_xml
        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.ThreeDSecure {
          xml.Enrolled @credentials.enrolled
          xml.PaRes @credentials.pa_res
          xml.MD @credentials.md
          xml.TransactionReference @credentials.transaction_reference
        }
      end
      
    end
    
  end
end