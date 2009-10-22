module BreadMachine

  # Order reference information for auditing purposes.
  #
  class OrderInfo

    attr_accessor :order_reference, :order_information

    # It is strongly advised that these properties are included in transactions,
    # but they are not required.
    #
    # Suggested usage:
    #
    # :order_reference should be something like the order or invoice number.
    # :order_information could be the first 255 characters of the names of the
    #    items in the order (as an example) - basically anything that can
    #    identify an order in a human-friendly way.
    #
    def initialize(attributes = {})
      attributes.each { |key, value| send("#{key}=", value) }
    end

  end

end

