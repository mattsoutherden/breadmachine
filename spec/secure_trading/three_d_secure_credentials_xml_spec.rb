require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BreadMachine::SecureTrading::ThreeDSecureCredentialsXml do
  
  before(:each) do
    @credentials = BreadMachine::ThreeDSecureCredentials.new
  end

  subject do
    described_class.new(@credentials)
  end
  
  def generated_xml
    Nokogiri::XML::Document.parse(subject.to_xml)
  end
  
  it "should have correct root element" do
    generated_xml.should have_tag('/ThreeDSecure')
  end
  
  it "should correctly populate Enrolled element" do
    @credentials.enrolled = 'Y'
    generated_xml.should have_tag('ThreeDSecure/Enrolled', 'Y')
  end
  
  it "should correctly populate PaRes element" do
    @credentials.pa_res = 'A_PA_RES_VALUE'
    generated_xml.should have_tag('ThreeDSecure/PaRes', 'A_PA_RES_VALUE')
  end
  
  it "should correctly populate MD element" do
    @credentials.md = 'A_MD_VALUE'
    generated_xml.should have_tag('ThreeDSecure/MD', 'A_MD_VALUE')
  end
  
  it "should correctly populate TransactionReference element" do
    @credentials.transaction_reference = '121-43-422344'
    generated_xml.should have_tag('ThreeDSecure/TransactionReference', '121-43-422344')
  end
  

end