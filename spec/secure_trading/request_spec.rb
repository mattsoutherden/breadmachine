# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BreadMachine::SecureTrading::Request do
  
  describe "XML generation" do
    
    before(:each) do
      @request = described_class.new(Builder::XmlMarkup.new)
    end
    
    it "should set xml instruct" do
      @request.to_xml.should match(%r{<\?xml version="1.0" encoding="UTF-8"\?>})
    end
    
    it "should output xml as utf-8" do
      xml = Builder::XmlMarkup.new
      xml.foo "Min luftpudebåd er fyldt med ål"
      @request = described_class.new(xml)
      @request.to_xml.should match(/Min luftpudeb&#229;d er fyldt med &#229;l/)
    end
    
    def request_xml
      Nokogiri::XML::Document.parse(@request.to_xml)
    end
  end
end
