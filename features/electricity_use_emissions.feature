Feature: Electricity Use Emissions Calculations
  The electricity use model should generate correct emission calculations

  Scenario Outline: Calculations from various inputs
    Given an electricity use has "kwh" of "<kwh>"
    And it has "zip_code.name" of "<zip_code>"
    When emissions are calculated
    Then the emission value should be within "0.1" kgs of "<emissions>"
    Examples:
      | kwh | zip_code | emissions |
      |     |          |     22080 |
      |   1 |    48915 |         2 |
      |   0 |    48915 |         0 |
