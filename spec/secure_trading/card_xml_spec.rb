require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BreadMachine::SecureTrading::CardXml do
  
  subject do
    described_class.new(@card)
  end
  
  def xml
    Nokogiri::XML::Document.parse(subject.to_xml)
  end

  describe "xml representation from card" do
    
    before(:each) do
      @card = BreadMachine::Card.new
    end

    it "should have CreditCard root element" do
      xml.should have_tag('/CreditCard')
    end
    
    it "should have correct Type element" do
      @card.issuer = 'Maestro'
      xml.should have_tag("CreditCard/Type", 'Maestro')
    end
    
    it "should have correct Number element" do
      @card.number = 6759050000000005
      xml.should have_tag("CreditCard/Number", '6759050000000005')
    end
    
    it "should have correct ExpiryDate element" do
      @card.expiry_date = '07/11'
      xml.should have_tag("CreditCard/ExpiryDate", '07/11')
    end
    
    it "should have correct StartDate element" do
      @card.start_date = '03/08'
      xml.should have_tag("CreditCard/StartDate", '03/08')
    end
    
    it "should have correct Issue element" do
      @card.issue = 2
      xml.should have_tag("CreditCard/Issue", '2')
    end
    
    it "should have correct SecurityCode element" do
      @card.security_code = 789
      xml.should have_tag("CreditCard/SecurityCode", '789')
    end
    
    it "should have correct ParentTransactionReference element" do
      @card.transaction_reference = '13-2-9875373'
      xml.should have_tag("CreditCard/ParentTransactionReference", '13-2-9875373')
    end
    
  end
  
  describe "xml representation from transaction" do
    
    before(:each) do
      @card = BreadMachine::Card.new
    end
    
    it "should have CreditCard root element" do
      xml.should have_tag('/CreditCard')
    end
    
    it "should have correct TransactionVerifier element" do
      @card.transaction_verifier = 'A_TRANSACTION_VERIFIER'
      xml.should have_tag("CreditCard/TransactionVerifier", 'A_TRANSACTION_VERIFIER')
    end
    
    it "should have correct ParentTransactionReference element" do
      @card.transaction_reference = 'A_TRANSACTION_REFERENCE'
      xml.should have_tag("CreditCard/ParentTransactionReference", 'A_TRANSACTION_REFERENCE')
    end
    
  end
  
end