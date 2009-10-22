module BreadMachine
  module SecureTrading
    
    class AuthReversalRequest
      
      def initialize(transaction, order_info)
        @transaction = transaction
        @order_info = BreadMachine::SecureTrading::OrderInfoXml.new(order_info)
      end
      
      def response(xml)
        AuthReversalResponse.new(xml)
      end
      
      def to_xml
        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.Request("Type" => "AUTHREVERSAL") {
          xml.Operation {
            xml.SiteReference BreadMachine::SecureTrading::configuration.site_reference
          }
          xml.PaymentMethod {
            xml.CreditCard {
              xml.ParentTransactionReference @transaction.transaction_reference
              xml.TransactionVerifier @transaction.transaction_verifier
            }
          }
          xml << @order_info.to_xml
        }
      end
      
    end
    
  end
end