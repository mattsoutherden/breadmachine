
When /^I perform an enrolment check for ([^\"]*) "([^\"]*)"$/ do |issuer, card_number|
  amount = Money.sterling(349_99)
  card = BreadMachine::Card.make(:issuer => issuer, :number => card_number)
  customer_info = BreadMachine::CustomerInfo.make(:card_query)
  order_info = BreadMachine::OrderInfo.make
  
  self.response = BreadMachine.three_d_secure_enrolled?(amount, card, customer_info, order_info)
end

When /^I perform an enrolment check for Visa "([^\"]*)" appending "([^\"]*)" to term_url$/ do |card_number, append|
  amount = Money.sterling(349_99)
  card = BreadMachine::Card.make(:issuer => 'Visa', :number => card_number)
  customer_info = BreadMachine::CustomerInfo.make(:card_query)
  order_info = BreadMachine::OrderInfo.make
  options = {:term_url_append => append}
  
  self.response = BreadMachine.three_d_secure_enrolled?(amount, card, customer_info, order_info, options)
end

When /^I perform an enrolment check using a previous transaction$/ do
  amount = Money.sterling(200_00)
  card = BreadMachine::Card.new(
    :transaction_verifier => response.transaction_verifier,
    :transaction_reference  => response.transaction_reference
    )
  customer_info = BreadMachine::CustomerInfo.make(:card_query)
  order_info = BreadMachine::OrderInfo.make
  self.response = BreadMachine.three_d_secure_enrolled?(amount, card, customer_info, order_info)
end

Then /^the response term_url should end in "([^\"]*)"$/ do |string|
  response.term_url.should match(/#{string}$/)
end

Then /^the response should be successful$/ do
  response.should be_successful
end

Then /^the response should not be successful$/ do
  response.should_not be_successful
end

Then /^the auth should be declined$/ do
  response.should be_declined
end

Then /^the card should be enrolled$/ do
  response.enrolled.should == 'Y'
end

Then /^the card should not be enrolled$/ do
  response.enrolled.should == 'N'
end

Then /^the auth type to perform should be "([^\"]*)"$/ do |auth_class|
  response.auth_type.should == BreadMachine::SecureTrading.const_get(auth_class)
end

When /^I submit a 3D Auth with valid details$/ do
  amount    = Money.sterling(149_50)
  card      = BreadMachine::Card.new(
    :security_code => '123',
    :transaction_verifier => response.transaction_verifier,
    :transaction_reference  => response.transaction_reference
    )
  customer  = BreadMachine::CustomerInfo.make(:auth)
  order     = BreadMachine::OrderInfo.make
  three_d   = BreadMachine::ThreeDSecureCredentials.new(
    :enrolled               => "Y",
    :pa_res                 => three_d_credentials.pa_res,
    :md                     => three_d_credentials.md,
    :transaction_reference  => three_d_credentials.reference
    )
    
  self.response = BreadMachine.three_d_auth(amount, card, customer, order, three_d, settle_day = 0)
end

When /^I submit a 3D Auth with valid details for non-enrolled Visa "([^\"]*)"$/ do |card_number|
  amount = Money.sterling(45_00)
  card = BreadMachine::Card.make(
    :issuer => 'Visa',
    :number => card_number,
    :transaction_reference  => response.transaction_reference
  )
  customer = BreadMachine::CustomerInfo.make(:auth)
  order = BreadMachine::OrderInfo.make
  three_d = BreadMachine::ThreeDSecureCredentials.new(
    :enrolled               => "N",
    :transaction_reference  => response.transaction_reference
  )
    
  self.response = BreadMachine.three_d_auth(amount, card, customer, order, three_d, settle_day = 0)
end

When /^I submit an Auth with valid details for (\d+)$/ do |card_number|
  amount    = Money.sterling(56_99)
  card      = BreadMachine::Card.make(:issuer => 'Amex', :number => card_number)
  customer  = BreadMachine::CustomerInfo.make(:auth)
  order     = BreadMachine::OrderInfo.make
    
  self.response = BreadMachine.auth(amount, card, customer, order, settle_day = 0)
end

When /^I submit a MOTO Auth with valid details for (\d+)$/ do |card_number|
  amount    = Money.sterling(89_99)
  card      = BreadMachine::Card.make(:issuer => 'Amex', :number => card_number)
  customer  = BreadMachine::CustomerInfo.make(:auth)
  order     = BreadMachine::OrderInfo.make
    
  self.response = BreadMachine.moto_auth(amount, card, customer, order, settle_day = 0)
end

When /^I submit a repeat auth$/ do
  amount      = Money.sterling(89_49)
  customer    = BreadMachine::CustomerInfo.make(:auth)
  order       = BreadMachine::OrderInfo.make
  card        = BreadMachine::Card.new(
    :transaction_verifier => response.transaction_verifier,
    :transaction_reference  => response.transaction_reference
  )
  
  self.response = BreadMachine.auth(amount, card, customer, order, settle_day = 0)
end

When /^I submit a repeat MOTO auth$/ do
  amount      = Money.sterling(89_49)
  customer    = BreadMachine::CustomerInfo.make(:auth)
  order       = BreadMachine::OrderInfo.make
  card        = BreadMachine::Card.new(
    :transaction_verifier => response.transaction_verifier,
    :transaction_reference  => response.transaction_reference
  )
  
  self.response = BreadMachine.moto_auth(amount, card, customer, order, settle_day = 0)
end


Given /^a successful auth$/ do
  When 'I submit an Auth with valid details for 377737773777380'
  Then 'the response should be successful'
end

Given /^a successful 3d secure authorisation$/ do
  When 'I perform an enrolment check for Visa "4111111111111160"'
  And 'I authenticate with the Access Control Server (ACS)'
  And 'I submit a 3D Auth with valid details'
  Then 'the response should be successful'
end

When /^I perform an auth reversal$/ do
  # until we get a fake gateway set up for testing, we have to wait for the
  # auth transaction to propogate on the SecureTrading test gateway
  # before we can reverse it
  sleep 15
  order     = BreadMachine::OrderInfo.make
  
  self.response = BreadMachine.reverse(self.response, order)
end
