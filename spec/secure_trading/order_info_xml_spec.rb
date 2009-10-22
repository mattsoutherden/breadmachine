require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BreadMachine::SecureTrading::OrderInfoXml do
  
  before(:each) do
    @order_info = BreadMachine::OrderInfo.new
  end

  subject do
    described_class.new(@order_info)
  end
  
  def generated_xml
    Nokogiri::XML::Document.parse(subject.to_xml)
  end
  
  it "should have correct root element" do
    generated_xml.should have_tag('/Order')
  end

  it "should have correct OrderReference" do
    @order_info.order_reference = 'Order 12345'
    generated_xml.should have_tag('Order/OrderReference', 'Order 12345')
  end
  
  it "should have correct OrderInformation" do
    @order_info.order_information = '1 Bag of Assorted Widgets'
    generated_xml.should have_tag('Order/OrderInformation', '1 Bag of Assorted Widgets')
  end

end