module BreadMachine

  # A data transfer object that represents the user's credit card.
  #
  class Card

    attr_accessor :issuer
    attr_accessor :number
    attr_accessor :expiry_date
    attr_accessor :start_date
    attr_accessor :issue
    attr_accessor :security_code
    attr_accessor :transaction_verifier
    attr_accessor :transaction_reference

    # Required properties include :issuer, :number, and :expiry_date.
    #
    # :issuer should be a downcased string ("amex", "visa", "mastercard")
    # :number should be an integer
    # :expiry_date should be a string in the format "mm/yy"
    #
    # :issue is required for Solo cards.
    # :start_date is required for "some" cards. The XPay spec says "for a full
    #   list of cards requiring start_date, please contact your acquiring bank".
    #
    # TODO: make expiry_date and start_date into Date objects to save crappy
    # string munging.
    #
    def initialize(attributes = {})
      attributes.each { |key, value| send("#{key}=", value) }
    end

  end

end

