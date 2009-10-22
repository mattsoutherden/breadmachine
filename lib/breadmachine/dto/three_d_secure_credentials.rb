module BreadMachine
  
  class ThreeDSecureCredentials
    
    attr_accessor :enrolled, :pa_res, :md, :transaction_reference
    
    def initialize(attributes = {})
      attributes.each { |key, value| send("#{key}=", value) }
    end
    
  end
  
end