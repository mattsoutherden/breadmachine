Feature: 3d secure enrolment check

  In order to ascertain what kind of transaction to process
  As a merchant
  I want to check if a card is enrolled in the 3-D Secure scheme

  Scenario: Enrolled card
    Given Visa 4111111111111160 is enrolled in 3-D Secure
    When I perform an enrolment check for Visa "4111111111111160"
    Then the response should be successful
    And the card should be enrolled
    And the auth type to perform should be "St3dAuthRequest"
    
  Scenario: Non-enrolled card
    Given Visa 4111111111111111 is not enrolled in 3-D Secure
    When I perform an enrolment check for Visa "4111111111111111"
    Then the response should be successful
    And the card should not be enrolled
    And the auth type to perform should be "St3dAuthRequest"

  Scenario: Non-participating card
    Given Amex 377737773777380 is not enrolled in 3-D Secure
    When I perform an enrolment check for Amex "377737773777380"
    Then the response should be successful
    And the auth type to perform should be "AuthRequest"
  
  Scenario: Initiate card query from previous transaction
    Given a successful 3d secure authorisation
    When I perform an enrolment check using a previous transaction
    Then the response should be successful
    
  Scenario: Request redirect to a custom term_url with appended params
    Given Visa 4111111111111160 is enrolled in 3-D Secure
    When I perform an enrolment check for Visa "4111111111111160" appending "/some_resource" to term_url
    Then the response should be successful
    And the response term_url should end in "/some_resource"
  
  Scenario: Failure response