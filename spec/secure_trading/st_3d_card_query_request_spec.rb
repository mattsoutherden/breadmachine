require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BreadMachine::SecureTrading::St3dCardQueryRequest do
  
  it "should ensure amount is Money of correct currency" do
    BreadMachine::SecureTrading.configuration.currency = 'USD'
    amount = Money.new(200_00, 'GBP')
    
    lambda {
      @request = described_class.new(amount, @card, @customer_info, @order_info)
    }.should raise_error ArgumentError, "Currency mismatch"
  end

  context "XML generation" do
    
    before(:each) do
      BreadMachine::SecureTrading.configuration.currency = 'GBP'
      @card = BreadMachine::Card.make
      @customer_info = BreadMachine::CustomerInfo.make(:card_query)
      @order_info = BreadMachine::OrderInfo.make
      @amount = Money.sterling(12_99)
      @request = described_class.new(@amount, @card, @customer_info, @order_info)
    end
    
    it "should set correct request type" do
      request_xml.should have_tag("/Request[@Type='ST3DCARDQUERY']")
    end
    
    it "should populate Operation element with correct data" do
      BreadMachine::SecureTrading.configure do |config|
        config.currency = 'USD'
        config.site_reference = 'site12345'
        config.term_url = 'http://www.example.com'
        config.merchant_name = "Bob's Widgets Inc."
      end
      amount = Money.us_dollar(10_99)
      
      @request = described_class.new(amount, @card, @customer_info, @order_info)
      
      request_xml.should have_tag("Request/Operation")
      
      request_xml.should have_tag("Operation/Amount", "1099")
      request_xml.should have_tag("Operation/Currency", "USD")
      request_xml.should have_tag("Operation/SiteReference", "site12345")
      request_xml.should have_tag("Operation/TermUrl", "http://www.example.com")
      request_xml.should have_tag("Operation/MerchantName", "Bob's Widgets Inc.")
    end
    
    it "should append to term_url if set in options" do
      BreadMachine::SecureTrading.configuration.term_url = 'http://www.example.com'
      options = {:term_url_append => '/some_value'}
      
      @request = described_class.new(@amount, @card, @customer_info, @order_info, options)
      
      request_xml.should have_tag("Operation/TermUrl", "http://www.example.com/some_value")
    end
    
    it "should append CustomerInfo element" do
      request_xml.should have_tag("Request/CustomerInfo")
    end
    
    it "should append PaymentMethod element" do
      request_xml.should have_tag("Request/PaymentMethod")
    end
        
    it "should append Order element" do
      request_xml.should have_tag("Request/Order")
    end
    
    def request_xml
      Nokogiri::XML::Document.parse(@request.to_xml)
    end
  end
end
