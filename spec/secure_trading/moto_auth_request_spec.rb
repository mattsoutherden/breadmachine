require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BreadMachine::SecureTrading::MotoAuthRequest do
  
  it "should ensure amount is Money of correct currency" do
    BreadMachine::SecureTrading.configuration.currency = 'USD'
    amount = Money.new(200_00, 'GBP')
    
    lambda {
      @request = described_class.new(amount, @card, @customer_info, @order_info, @settlement_day)
    }.should raise_error ArgumentError, "Currency mismatch"
  end
  
  describe "XML generation" do
    
    before(:each) do
      BreadMachine::SecureTrading.configuration.currency = 'GBP'
      @amount = Money.sterling(12_99)
      @card = BreadMachine::Card.make
      @customer_info = BreadMachine::CustomerInfo.make(:auth)
      @order_info = BreadMachine::OrderInfo.make
      @settlement_day = 1
      @request = described_class.new(@amount, @card, @customer_info, @order_info, @settlement_day)
    end
    
    it "should set correct request type" do
      request_xml.should have_tag("/Request[@Type='MOTOAUTH']")
    end
    
    it "should populate Operation element with correct data" do
      BreadMachine::SecureTrading.configure do |config|
        config.currency = 'GBP'
        config.site_reference = 'site12345'
      end
      amount = Money.sterling(12_50)
      
      @request = described_class.new(amount, @card, @customer_info, @order_info, settlement_day = 3)
      
      request_xml.should have_tag("Operation") do |operation|
        operation.document.should have_tag("Amount", "1250")
        operation.document.should have_tag("Currency", "GBP")
        operation.document.should have_tag("SiteReference", "site12345")
        operation.document.should have_tag("SettlementDay", "3")
      end
    end
    
    it "should append CustomerInfo element" do
      request_xml.should have_tag("Request/CustomerInfo")
    end
    
    it "should append CreditCard element" do
      request_xml.should have_tag("PaymentMethod/CreditCard")
    end
    
    it "should append Order element" do
      request_xml.should have_tag("Order")
    end
    
    def request_xml
      Nokogiri::XML::Document.parse(@request.to_xml)
    end
  end
end
