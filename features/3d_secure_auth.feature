Feature: 3d secure auth feature
  In order to value
  As a role
  I want feature

  Scenario: Successful Auth
    Given Visa 4111111111111160 is enrolled in 3-D Secure
    When I perform an enrolment check for Visa "4111111111111160"
    And I authenticate with the Access Control Server (ACS)
    And I submit a 3D Auth with valid details
    Then the response should be successful
  
  Scenario: Failed 3-D Secure Verification
    Given Visa 4111111111111160 is enrolled in 3-D Secure
    When I perform an enrolment check for Visa "4111111111111160"
    And I fail authentication with the Access Control Server (ACS)
    And I submit a 3D Auth with valid details
    Then the response should not be successful
    
  Scenario: Non-enrolled Card
    Given Visa 4111111111111111 is not enrolled in 3-D Secure
    When I perform an enrolment check for Visa "4111111111111111"
    When I submit a 3D Auth with valid details for non-enrolled Visa "4111111111111111"
    Then the response should be successful
  
  Scenario: Decline Auth
    Given Visa 4111111111111392 is enrolled in 3-D Secure
    When I perform an enrolment check for Visa "4111111111111392"
    And I authenticate with the Access Control Server (ACS)
    And I submit a 3D Auth with valid details
    Then the auth should be declined