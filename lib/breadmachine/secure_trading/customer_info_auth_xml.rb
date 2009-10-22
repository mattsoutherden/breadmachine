module BreadMachine
  module SecureTrading
    
    class CustomerInfoAuthXml
      
      def initialize(customer_info)
        @customer_info = customer_info
      end
      
      def to_xml
        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.CustomerInfo {
          xml.Postal {
            xml.Name {
              xml.NamePrefix @customer_info.name_prefix
              xml.FirstName @customer_info.first_name
              xml.MiddleName @customer_info.middle_name
              xml.LastName @customer_info.last_name
              xml.NameSuffix @customer_info.name_suffix
            }
            xml.Company @customer_info.company
            xml.Street @customer_info.street
            xml.City @customer_info.city
            xml.StateProv @customer_info.state
            xml.PostalCode @customer_info.postcode
            xml.CountryCode @customer_info.iso_2_country
          }
          xml.Telecom {
            xml.Phone @customer_info.telephone
          }
          xml.Online {
            xml.Email @customer_info.email
          }
        }
      end
      
    end
    
  end
end