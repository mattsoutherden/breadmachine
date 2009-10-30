module BreadMachine
  module SecureTrading
    
    class Request
      
      def initialize(request)
        @request = request
      end
      
      def to_xml
        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.instruct!(:xml, :encoding => "UTF-8")
        xml.RequestBlock('Version' => '3.51') do |request_block|
          request_block << @request.to_xml
          xml.Certificate BreadMachine::SecureTrading::configuration.site_reference
        end
        return xml.target!
      end
      
    end
    
  end
end