module BreadMachine
  module SecureTrading
    
    class CustomerInfoEnrolmentXml
      
      def initialize(customer_info)
        @customer_info = customer_info
      end
      
      def to_xml
        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.CustomerInfo {
          xml.Accept @customer_info.accept
          xml.UserAgent @customer_info.user_agent
        }
      end
      
    end
    
  end
end