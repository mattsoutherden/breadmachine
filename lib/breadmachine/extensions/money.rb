class Money
  class << self
    
    def sterling(amount)
      Money.new(amount, "GBP")
    end
    
  end
end
