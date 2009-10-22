module BreadMachine
  module SecureTrading
    
    class Config
      
      attr_accessor :currency, :site_reference, :term_url, :merchant_name
      
      module ClassMethods
        def configuration
          @configuration ||= BreadMachine::SecureTrading::Config.new
        end

        def configure(&block)
          yield configuration
        end
      end
      
    end
    
  end
end