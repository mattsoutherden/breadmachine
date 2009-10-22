When /^I authenticate with the Access Control Server \(ACS\)$/ do
  # Post details to the first SecureTrading 3-D Secure testing resource
  bank_3d_secure_page = RestClient.post(response.acs_url, :MD => response.md, :PaReq => response.pa_req, :TermUrl => 'http://www.example.com')
  # "Submit" the test 3-D Secure form using the code to mimic a successful user authentication
  redirect_page = RestClient.post("https://securetrading.net/secureweb/testacs.cgi", :st_username=> 'sty', :MD => response.md, :PaReq => response.pa_req, :TermUrl => 'http://www.example.com')
  # Store the 3-D Secure tokens so they can be used in subsequent auth requests
  doc = Nokogiri::HTML.parse(redirect_page)
  self.three_d_credentials = OpenStruct.new(
    :pa_res     => doc.xpath("//input[@name='PaRes']").first.attribute('value'),
    :md         => doc.xpath("//input[@name='MD']").first.attribute('value'),
    :reference  => response.transaction_reference )
end

When /^I fail authentication with the Access Control Server \(ACS\)$/ do
  # Post details to the first SecureTrading 3-D Secure testing resource
  bank_3d_secure_page = RestClient.post(response.acs_url, :MD => response.md, :PaReq => response.pa_req, :TermUrl => 'http://www.example.com')
  # "Submit" the test 3-D Secure form using the code to mimic a successful user authentication
  # st_username is an element on the 
  redirect_page = RestClient.post("https://securetrading.net/secureweb/testacs.cgi", :st_username=> 'stn', :MD => response.md, :PaReq => response.pa_req, :TermUrl => 'http://www.example.com')
  # puts redirect_page
  # Store the 3-D Secure tokens so they can be used in subsequent auth requests
  doc = Nokogiri::HTML.parse(redirect_page)
  self.three_d_credentials = OpenStruct.new(
    :pa_res     => doc.xpath("//input[@name='PaRes']").first.attribute('value'),
    :md         => doc.xpath("//input[@name='MD']").first.attribute('value'),
    :reference  => response.transaction_reference )
end