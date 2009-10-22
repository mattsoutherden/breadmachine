Feature: Auth
  In order to take payment
  As a merchant
  I want to create a transaction

  Scenario: Successful Auth
    Given Amex 377737773777380 is a valid card
    And I submit an Auth with valid details for 377737773777380
    Then the response should be successful
  
  Scenario: Failed Auth
    Given Amex 377737773777422 is not a valid card
    And I submit an Auth with valid details for 377737773777422
    Then the response should not be successful

