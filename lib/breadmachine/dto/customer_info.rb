module BreadMachine

  # Billing details for customer.  This is used by XPay and the acquiring banks
  # to keep an audit trail for fraud prevention purposes, so it's necessary for
  # some kinds of auth queries (e.g. AVS checks).
  #
  class CustomerInfo

    attr_accessor :name_prefix, :first_name, :middle_name, :last_name, :name_suffix,
                  :company, :street, :city, :state, :postcode, :iso_2_country,
                  :telephone, :email,
                  :accept, :user_agent

    # XPay doesn't require any of this info for regular transactions, but if
    # you've got your XPay system set up to decline if an AVS check fails, you'd
    # better include it.
    #
    # 3-D Secure card enrollment checks *require* :user_agent and :accept
    #
    # The XPay API reference strongly recommends that all of this info is filled
    # in, regardless of what kind of API call you're making.
    #
    def initialize(attributes = {})
      attributes.each { |key, value| send("#{key}=", value) }
    end

  end

end

