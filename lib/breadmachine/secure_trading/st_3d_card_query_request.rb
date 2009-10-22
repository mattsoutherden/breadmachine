module BreadMachine
  module SecureTrading

    # A 3-D Secure query to figure out whether a given card is enrolled in
    # 3-D Secure.  Although XPay doesn't absolutely require all of the order
    # information etc., BreadMachine does as it's better for history tracking
    # and is strongly recommended by XPay.
    #
    class St3dCardQueryRequest

      def initialize(amount, card, customer_info, order_info, options = {})
        raise ArgumentError, 'Currency mismatch' unless amount.currency == BreadMachine::SecureTrading::configuration.currency

        @amount = amount
        @customer_info = BreadMachine::SecureTrading::CustomerInfoEnrolmentXml.new(customer_info)
        @order_info = BreadMachine::SecureTrading::OrderInfoXml.new(order_info)
        @card = BreadMachine::SecureTrading::CardXml.new(card)
        @options = options
      end

      def response(xml)
        St3dCardQueryResponse.new(xml)
      end

      def to_xml
        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.Request("Type" => "ST3DCARDQUERY") {
          xml.Operation {
            xml.Amount @amount.cents
            xml.Currency BreadMachine::SecureTrading::configuration.currency
            xml.SiteReference BreadMachine::SecureTrading::configuration.site_reference
            xml.TermUrl self.term_url
            xml.MerchantName BreadMachine::SecureTrading::configuration.merchant_name
          }
          xml << @customer_info.to_xml
          xml.PaymentMethod {
            xml << @card.to_xml
          }
          xml << @order_info.to_xml
        }
      end
      
      protected
      
      def term_url
        if @options.key?(:term_url_append)
          BreadMachine::SecureTrading::configuration.term_url + @options[:term_url_append]
        else
          BreadMachine::SecureTrading::configuration.term_url
        end
      end
    end

  end
end

