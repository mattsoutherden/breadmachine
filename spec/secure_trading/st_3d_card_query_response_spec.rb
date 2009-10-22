require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BreadMachine::SecureTrading::St3dCardQueryResponse do
  
  describe "#successful?" do

    it "should be successful when Result element is 1" do
      response = described_class.new(successful_response(result = 1))
      response.should be_successful
    end

    it "should be successful when Result element is 2" do
      response = described_class.new(successful_response(result = 2))
      response.should be_successful
    end

    it "should not be successful when Result element is 0" do
      response = described_class.new(failed_response)
      response.should_not be_successful
    end

  end
  
  describe "#error?" do
    
    it "should be error when Result element is 0" do
      response = described_class.new(failed_response)
      response.should be_error
    end

    it "should not be error when Result element is 1" do
      response = described_class.new(successful_response(result = 1))
      response.should_not be_error
    end

    it "should not be error when Result element is 2" do
      response = described_class.new(successful_response(result = 2))
      response.should_not be_error
    end
    
  end
  
  describe "accessors" do
  
    it "should select PaReq" do
      response = described_class.new(successful_response)
      response.pa_req.should == "EXAMPLE-PA-REQ"
    end
  
    it "should select MD" do
      response = described_class.new(successful_response)
      response.md.should == "EXAMPLE-MD"
    end
  
    it "should select AcsUrl" do
      response = described_class.new(successful_response)
      response.acs_url.should == "https://securetrading.net/secureweb/testacs0.cgi"
    end
  
    it "should select TranscationReference" do
      response = described_class.new(successful_response)
      response.transaction_reference.should == "15-9-1266891"
    end
    
    it "should select Enrolled" do
      response = described_class.new(successful_response)
      response.enrolled.should == "Y"
    end
    
  end
  
  describe "Auth type" do
    
    it "should return s3 secure auth for auth type when card is enrolled" do
      response = described_class.new(successful_response(result = 1, enrolled = 'Y'))
      response.auth_type.should == BreadMachine::SecureTrading::St3dAuthRequest
    end
    
    it "should return s3 secure auth for auth type when card is not enrolled" do
      response = described_class.new(successful_response(result = 1, enrolled = 'N'))
      response.auth_type.should == BreadMachine::SecureTrading::St3dAuthRequest
    end

    it "should return standard auth for auth type when card provider is not part of scheme" do
      response = described_class.new(successful_response(result = 2))
      response.auth_type.should == BreadMachine::SecureTrading::AuthRequest
    end
    
    it "should return standard auth for auth type when response is error" do
      response = described_class.new(successful_response(result = 0))
      response.auth_type.should == BreadMachine::SecureTrading::AuthRequest
    end
    
  end


  
  def successful_response(result = 1, enrolled = 'Y')
    <<-XML
    <ResponseBlock Live="FALSE" Version="3.51">
      <Response Type="ST3DCARDQUERY">
        <OperationResponse>
          <TransactionReference>15-9-1266891</TransactionReference>
          <TransactionCompletedTimestamp>2009-09-24 14:50:41</TransactionCompletedTimestamp>
          <TransactionVerifier>AY4LBwreQ1qwbPpuH5PswO4eN7KD27qmNBLG03tCrhBSzLpRXKBXw+PwY7dcuzuGoQXAPVB7phZYZhcP8YcBy9LFXO8zRW02QaHhXXykY7+ekmsYdNGEYjeLE8wI2vUGpD9IrGySGgYQySq1zIFg1wtUg4LmyrlAlUyQUOvPof8c=</TransactionVerifier>
          <Result>#{result}</Result>
          <Enrolled>#{enrolled}</Enrolled>
          <Html></Html>
          <MD>EXAMPLE-MD</MD>
          <PaReq>EXAMPLE-PA-REQ</PaReq>
          <TermUrl>http://www.example.com</TermUrl>
          <AcsUrl>https://securetrading.net/secureweb/testacs0.cgi</AcsUrl>
        </OperationResponse>
        <Order>
          <OrderInformation>1x Assorted Widgets</OrderInformation>
          <OrderReference>TestOrder12345</OrderReference>
        </Order>
      </Response>
    </ResponseBlock>
    XML
  end
  
  def failed_response
    <<-EOS
    <ResponseBlock Live="" Version="3.51">
      <Response Type="ST3DCARDQUERY">
        <OperationResponse>
          <Message>(3100) Invalid CreditCardNumber</Message>
          <TransactionReference>0-0-0</TransactionReference>
          <Result>0</Result>
        </OperationResponse>
      </Response>
    </ResponseBlock>
    EOS
  end
end
