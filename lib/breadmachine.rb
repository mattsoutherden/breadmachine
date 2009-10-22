require 'money'
require 'nokogiri'
require 'builder'
require 'activesupport'

require 'breadmachine/extensions'
require 'breadmachine/secure_trading'

module BreadMachine
  
  autoload :Card, 'breadmachine/dto/card'
  autoload :CustomerInfo, 'breadmachine/dto/customer_info'
  autoload :OrderInfo, 'breadmachine/dto/order_info'
  autoload :ThreeDSecureCredentials, 'breadmachine/dto/three_d_secure_credentials'
  
  extend SecureTrading::PaymentMethods
  
end

class Builder::XmlBase
  
  # Make generated xml easier to read by indenting appended xml strings out to
  # the current indent level.
  def <<(text)
    _text(text.indent(@level * @indent))
  end
end

class BreadMachine::Exception < Exception; end;
class BreadMachine::GatewayConnectionError < BreadMachine::Exception; end;
class BreadMachine::MerchantConfigurationError < BreadMachine::Exception; end;
class BreadMachine::MerchantRequestError < BreadMachine::Exception; end;