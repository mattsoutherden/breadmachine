Given /^(?:Visa|Amex|MasterCard|Maestro) \d+ is .*$/ do
  # noop; just syntactic sugar for the scenarios until we create a fake gateway
  # for testing, the results of querying the SecureTrading test gateway are
  # dependent on the submitted card details.
end
