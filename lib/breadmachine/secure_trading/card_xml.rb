module BreadMachine
  module SecureTrading

    class CardXml
      
      def initialize(card)
        @card = card
      end
      
      def to_xml
        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.CreditCard {
          xml.Type @card.issuer unless @card.issuer.blank?
          xml.Number @card.number unless @card.number.blank?
          xml.ExpiryDate @card.expiry_date unless @card.expiry_date.blank?
          xml.StartDate @card.start_date unless @card.start_date.blank?
          xml.Issue @card.issue unless @card.issue.blank?
          xml.SecurityCode @card.security_code unless @card.security_code.blank?
          xml.TransactionVerifier @card.transaction_verifier unless @card.transaction_verifier.blank?
          xml.ParentTransactionReference @card.transaction_reference unless @card.transaction_reference.blank?
        }
      end
      
    end
    
  end
end