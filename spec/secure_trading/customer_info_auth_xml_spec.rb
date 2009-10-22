require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BreadMachine::SecureTrading::CustomerInfoAuthXml do
  
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
    
  describe "postal details" do
    
    describe "name elements" do
    
      it "should have correct NamePrefix" do
        @customer_info.name_prefix = 'Dr'
        generated_xml.should have_tag('Postal/Name/NamePrefix', 'Dr')
      end
    
      it "should have correct FirstName" do
        @customer_info.first_name = 'John'
        generated_xml.should have_tag('Postal/Name/FirstName', 'John')
      end
    
      it "should have correct MiddleName" do
        @customer_info.middle_name = 'Jonny'
        generated_xml.should have_tag('Postal/Name/MiddleName', 'Jonny')
      end
    
      it "should have correct LastName" do
        @customer_info.last_name = 'Johnson'
        generated_xml.should have_tag('Postal/Name/LastName', 'Johnson')
      end
    
      it "should have correct NameSuffix" do
        @customer_info.name_suffix = 'Esquire'
        generated_xml.should have_tag('Postal/Name/NameSuffix', 'Esquire')
      end
      
    end
    
    it "should have correct Company" do
      @customer_info.company = 'Widgets Inc.'
      generated_xml.should have_tag('Postal/Company', 'Widgets Inc.')
    end
    
    it "should have correct Street" do
      @customer_info.street = '1A Juan Street'
      generated_xml.should have_tag('Postal/Street', '1A Juan Street')
    end
    
    it "should have correct City" do
      @customer_info.city = 'London'
      generated_xml.should have_tag('Postal/City', 'London')
    end
    
    it "should have correct StateProv" do
      @customer_info.state = 'Greater London'
      generated_xml.should have_tag('Postal/StateProv', 'Greater London')
    end
    
    it "should have correct PostalCode" do
      @customer_info.postcode = 'W1 4PH'
      generated_xml.should have_tag('Postal/PostalCode', 'W1 4PH')
    end
    
    it "should have correct CountryCode" do
      @customer_info.iso_2_country = 'GB'
      generated_xml.should have_tag('Postal/CountryCode', 'GB')
    end
    
  end
  
  it "should have correct Phone" do
    @customer_info.telephone = '020 8888 8888'
    generated_xml.should have_tag('Telecom/Phone', '020 8888 8888')
  end
  
  it "should have correct Email" do
    @customer_info.email = 'john.jonny.johnson@example.com'
    generated_xml.should have_tag('Online/Email', 'john.jonny.johnson@example.com')
  end

end