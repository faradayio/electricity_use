Feature: Electricity Use Emissions Calculations
  The electricity use model should generate correct emission calculations

  Background:
    Given a electricity_use

  Scenario Outline: Calculations from various inputs
    Given it has "energy" of "<kwh>"
    And it has "zip_code.name" of "<zip_code>"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.1" kgs of "<emissions>"
    Examples:
      | kwh | zip_code | emissions |
      |     |          |     27600 |
      |   1 |    48915 |       2.5 |
      |   0 |    48915 |         0 |

  Scenario Outline: Calculations over various timeframes
    Given it has "date" of "<date>"
    And it is the year "2011"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.1" kgs of "<emissions>"
    Examples:
      | date       | emissions |
      | 2010-06-25 |       0.0 |
      | 2011-06-25 |   27600.0 |
      | 2012-06-25 |       0.0 |
