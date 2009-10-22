Feature: Repeat auth
  In order to facilitate purchases mimicing stored card details
  As a merchant
  I want to process an auth based on a previous auth

  Scenario: Successful repeat auth
    Given a successful auth
    When I submit a repeat auth
    Then the response should be successful
  
  Scenario: Repeat MOTO auth
    Given a successful auth
    When I submit a repeat MOTO auth
    Then the response should be successful
  
  
  
  
