Feature: Electricity Use Emissions Calculations
  The electricity use model should generate correct emission calculations

  Background:
    Given a electricity_use

  Scenario Outline: Calculations from various inputs
    Given it has "energy" of "<mj>"
    And it has "zip_code.name" of "<zip_code>"
    And it has "state.postal_abbreviation" of "<state>"
    And it has "country.iso_3166_code" of "<country>"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.1" of "<emissions>"
    Examples:
      |  mj | zip_code | state | country | emissions  |
      |     |          |       |         | 7961.87018 |
      |   0 |          |       |         |    0.0     |
      | 360 |    94122 |       |         |   32.63158 |
      | 360 |          | CA    |         |   32.87815 |
      | 360 |          |       | US      |   62.75972 |
      | 360 |          |       | UM      |   69.25774 |

  Scenario Outline: Calculations over various timeframes
    Given it has "date" of "<date>"
    And it is the year "2011"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.1" of "<emissions>"
    Examples:
      | date       | emissions  |
      | 2011-06-25 | 7961.87018 |
      | 2010-06-25 |    0.0     |
