require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BreadMachine::SecureTrading::CustomerInfoEnrolmentXml do
  
  before(:each) do
    @customer_info = BreadMachine::CustomerInfo.new
  end

  subject do
    described_class.new(@customer_info)
  end
  
  def generated_xml
    Nokogiri::XML::Document.parse(subject.to_xml)
  end
  
  it "should have correct root element" do
    generated_xml.should have_tag('/CustomerInfo')
  end
  
  it "should have correct Accept" do
    @customer_info.accept = 'text/html'
    generated_xml.should have_tag('CustomerInfo/Accept', 'text/html')
  end
  
  it "should have correct UserAgent" do
    @customer_info.user_agent = 'Internet Exploder 5.2'
    generated_xml.should have_tag('CustomerInfo/UserAgent', 'Internet Exploder 5.2')
  end

end