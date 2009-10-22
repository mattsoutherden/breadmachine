require 'machinist/object'

BreadMachine::Card.blueprint do
  issuer      { 'Visa' }
  number      { 4111111111111111 }
  expiry_date { Date.today.strftime("%m/%y") }
end

BreadMachine::CustomerInfo.blueprint {}

BreadMachine::CustomerInfo.blueprint(:card_query) do
  accept     { "text/html" }
  user_agent { "Mozilla/5.0" }
end

BreadMachine::CustomerInfo.blueprint(:auth) do
  first_name    { "Joe"}
  last_name     { "Bloggs" }
  street        { "29 Acacia Road" }
  city          { "London" }
  state         { "Greater London" }
  postcode      { "W1T 2DQ" }
  iso_2_country { "GB" }
  telephone     { "020 7323 9787" }
  email         { "nobody@example.com" }
end

BreadMachine::ThreeDSecureCredentials.blueprint do
  transaction_reference { '13-3-4312345' }
  enrolled              { "Y" }
  pa_res                { "PA-RES" }
  md                    { "MD" }
end

BreadMachine::OrderInfo.blueprint do
  order_reference   { "TestOrder12345" }
  order_information { "1x Assorted Widgets" }
end
