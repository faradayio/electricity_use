Feature: Electricity Use Emissions Calculations
  The electricity use model should generate correct emission calculations

  Background:
    Given a electricity_use

  Scenario Outline: Calculations from various inputs
    Given it has "energy" of "<mj>"
    And it has "zip_code.name" of "<zip_code>"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.1" of "<emissions>"
    Examples:
      |  mj | zip_code | emissions |
      |     |          |    8785.1 |
      |   0 |    94122 |       0.0 |
      | 360 |    94122 |     111.1 |

  Scenario Outline: Calculations over various timeframes
    Given it has "date" of "<date>"
    And it is the year "2011"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.1" of "<emissions>"
    Examples:
      | date       | emissions |
      | 2010-06-25 |       0.0 |
      | 2011-06-25 |    8785.1 |
      | 2012-06-25 |       0.0 |
