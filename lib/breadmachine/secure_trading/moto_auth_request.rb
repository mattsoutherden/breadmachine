module BreadMachine
  module SecureTrading
    
    class MotoAuthRequest
      
      def initialize(amount, card, customer_info, order_info, settlement_day)
        raise ArgumentError, 'Currency mismatch' unless amount.currency == BreadMachine::SecureTrading::configuration.currency
        
        @amount = amount
        @card = BreadMachine::SecureTrading::CardXml.new(card)
        @customer_info = BreadMachine::SecureTrading::CustomerInfoAuthXml.new(customer_info)
        @order_info = BreadMachine::SecureTrading::OrderInfoXml.new(order_info)
        @settlement_day = settlement_day
      end
      
      def response(xml)
        St3dAuthResponse.new(xml)
      end
      
      def to_xml
        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.Request("Type" => "MOTOAUTH") {
          xml.Operation {
            xml.Amount @amount.cents
            xml.Currency BreadMachine::SecureTrading::configuration.currency
            xml.SiteReference BreadMachine::SecureTrading::configuration.site_reference
            xml.SettlementDay @settlement_day
          }
          xml << @customer_info.to_xml
          xml.PaymentMethod {
            xml << @card.to_xml
          }
          xml << @order_info.to_xml
        }
      end
      
    end
    
  end
end