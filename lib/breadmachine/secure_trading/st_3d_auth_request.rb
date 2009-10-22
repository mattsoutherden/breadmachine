module BreadMachine
  module SecureTrading

    class St3dAuthRequest

      # A 3-D Secure auth reqeust to ask XPay to reserve funds at an acquiring
      # bank, checking whether this card has funds available to cover the given
      # amount.
      #
      # Although XPay doesn't absolutely require all of the order
      # information etc., BreadMachine does as it's better for history tracking
      # and is strongly recommended by XPay.
      #
      # settlement_day allows you to tell XPay when the auth request should be
      # queued for settlement.  The default, 1 day, will automatically tell
      # SecureTrading to settle the amount on the day after the auth request.
      # Note that even if you pass nil to settlement_day, the standard behaviour
      # of XPay is to queue the auth request for settlement 1 day after the auth
      # request.  Passing a settlement_day of 0 will tell XPay not to settle
      # without manual intervention.
      #
      def initialize(amount, card, customer_info, order_info, three_d_secure, settlement_day)
        raise ArgumentError, 'Currency mismatch' unless amount.currency == BreadMachine::SecureTrading::configuration.currency

        @amount = amount
        @card = BreadMachine::SecureTrading::CardXml.new(card)
        @customer_info = BreadMachine::SecureTrading::CustomerInfoAuthXml.new(customer_info)
        @order_info = BreadMachine::SecureTrading::OrderInfoXml.new(order_info)
        @three_d_secure = BreadMachine::SecureTrading::ThreeDSecureCredentialsXml.new(three_d_secure)
        @settlement_day = settlement_day
      end

      # The specific response for this request to the XPay daemon.
      #
      def response(xml)
        St3dAuthResponse.new(xml)
      end

      # Generate the expected XML for this XPay request.
      #
      def to_xml
        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.Request("Type" => "ST3DAUTH") {
          xml.Operation {
            xml.Amount @amount.cents
            xml.Currency BreadMachine::SecureTrading::configuration.currency
            xml.SiteReference BreadMachine::SecureTrading::configuration.site_reference
            xml.SettlementDay @settlement_day
          }
          xml << @customer_info.to_xml
          xml.PaymentMethod {
            xml << @card.to_xml
            xml << @three_d_secure.to_xml
          }
          xml << @order_info.to_xml
        }
      end

    end

  end
end

