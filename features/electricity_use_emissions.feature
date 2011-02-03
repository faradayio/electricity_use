Feature: Electricity Use Emissions Calculations
  The electricity use model should generate correct emission calculations

  Scenario Outline: Calculations from various inputs
    Given an electricity use has "energy" of "<kwh>"
    And it has "zip_code.name" of "<zip_code>"
    When emissions are calculated
    Then the emission value should be within "0.1" kgs of "<emissions>"
    Examples:
      | kwh | zip_code | emissions |
      |     |          |     27600 |
      |   1 |    48915 |       2.5 |
      |   0 |    48915 |         0 |

  Scenario Outline: Calculations over various timeframes
    Given an electricity use has "date" of "<date>"
    And it is the year "2011"
    When emissions are calculated
    Then the emission value should be within "0.1" kgs of "<emissions>"
    Examples:
      | date       | emissions |
      | 2010-06-25 |       0.0 |
      | 2011-06-25 |   27600.0 |
      | 2012-06-25 |       0.0 |
