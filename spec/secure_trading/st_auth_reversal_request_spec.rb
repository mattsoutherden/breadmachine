require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BreadMachine::SecureTrading::AuthReversalRequest do
  
  before(:each) do
    transaction = mock('transaction')
    transaction.stub(:transaction_reference => 'A_TRANSACTION_REFERENCE')
    transaction.stub(:transaction_verifier => 'A_TRANSACTION_VERIFIER')
    @order_info = BreadMachine::OrderInfo.make
    @request = described_class.new(transaction, @order_info)
  end

  describe "XML generation" do
    
    def xml
      Nokogiri::XML::Document.parse(@request.to_xml)
    end
    
    it "should set correct request type" do
      xml.should have_tag("/Request[@Type='AUTHREVERSAL']")
    end
    
    it "should populate Operation element with correct data" do
      BreadMachine::SecureTrading.configuration.site_reference = 'site12345'
      
      xml.should have_tag("Request/Operation")
      xml.should have_tag("Operation/SiteReference", "site12345")
    end

    it "should append CreditCard element" do
      xml.should have_tag("Request/PaymentMethod/CreditCard")
    end
        
    it "should append Order element" do
      xml.should have_tag("Request/Order")
    end
  end
  
  it "should return correct response" do
    @request.response('<xml>').should be_a(BreadMachine::SecureTrading::AuthReversalResponse)
  end
end
