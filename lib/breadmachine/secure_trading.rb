module BreadMachine
  
  module SecureTrading

    autoload :Config, 'breadmachine/secure_trading/config'
    autoload :PaymentMethods, 'breadmachine/secure_trading/payment_methods'

    autoload :XPay, 'breadmachine/secure_trading/xpay'
    autoload :XPaySocket, 'breadmachine/secure_trading/xpay_socket'
    autoload :XpayResponse, 'breadmachine/secure_trading/xpay_response'

    autoload :CardXml, 'breadmachine/secure_trading/card_xml'
    
    autoload :CustomerInfoAuthXml, 'breadmachine/secure_trading/customer_info_auth_xml'
    autoload :CustomerInfoEnrolmentXml, 'breadmachine/secure_trading/customer_info_enrolment_xml'
    autoload :ThreeDSecureCredentialsXml, 'breadmachine/secure_trading/three_d_secure_credentials_xml'
    autoload :OrderInfoXml, 'breadmachine/secure_trading/order_info_xml'

    autoload :St3dCardQueryRequest, 'breadmachine/secure_trading/st_3d_card_query_request'
    autoload :St3dCardQueryResponse, 'breadmachine/secure_trading/st_3d_card_query_response'
    
    autoload :St3dAuthRequest, 'breadmachine/secure_trading/st_3d_auth_request'
    autoload :St3dAuthResponse, 'breadmachine/secure_trading/st_3d_auth_response'
    
    autoload :Request, 'breadmachine/secure_trading/request'
    
    autoload :AuthRequest, 'breadmachine/secure_trading/auth_request'
    autoload :MotoAuthRequest, 'breadmachine/secure_trading/moto_auth_request'

    autoload :AuthReversalRequest, 'breadmachine/secure_trading/auth_reversal_request'
    autoload :AuthReversalResponse, 'breadmachine/secure_trading/auth_reversal_response'

    extend BreadMachine::SecureTrading::Config::ClassMethods
    
  end
  
end