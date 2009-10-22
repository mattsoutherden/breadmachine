require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BreadMachine::SecureTrading::XpayResponse do
  
  def response
    described_class.new(sample_response)
  end
  
  def sample_response
    <<-XML
    <ResponseBlock Live="FALSE" Version="3.51">
      <Response Type="ST3DCARDQUERY">
        <OperationResponse>
          <Result>1</Result>
        </OperationResponse>
      </Response>
    </ResponseBlock>
    XML
  end

  it "should select result from xml" do
    response.result.should == '1'
  end
  
  
end