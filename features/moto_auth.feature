Feature: MOTO Auth
  In order to take payment when a cardholder is not present
  As a merchant
  I want to create a MOTO transaction

  Scenario: Successful MOTO Auth
    Given Amex 377737773777380 is a valid card
    And I submit a MOTO Auth with valid details for 377737773777380
    Then the response should be successful
  
  Scenario: Failed MOTO Auth
    Given Amex 377737773777422 is not a valid card
    And I submit a MOTO Auth with valid details for 377737773777422
    Then the response should not be successful

