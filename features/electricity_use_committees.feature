Feature: Electricity Use Committee Calculations
  The electricity use model should generate correct committee calculations

  Background:
    Given a electricity_use

  Scenario: Date committee
    Given a characteristic "timeframe" of "2010-07-15/2010-07-20"
    When the "date" committee reports
    Then the conclusion of the committee should be "2010-07-15"

  Scenario: State committee
    Given a characteristic "zip_code.name" of "94122"
    When the "state" committee reports
    Then the committee should have used quorum "from zip code"
    And the conclusion of the committee should have "postal_abbreviation" of "CA"

  Scenario: eGRID subregion committee
    Given a characteristic "zip_code.name" of "94122"
    When the "egrid_subregion" committee reports
    Then the committee should have used quorum "from zip code"
    And the conclusion of the committee should have "abbreviation" of "CAMX"

  Scenario: Country committee
    Given a characteristic "state.postal_abbreviation" of "CA"
    When the "country" committee reports
    Then the committee should have used quorum "from state"
    And the conclusion of the committee should have "iso_3166_code" of "US"

  Scenario: Energy committee
    When the "energy" committee reports
    Then the committee should have used quorum "default"
    And the conclusion of the committee should be "41385.6"

  Scenario Outline: Loss factor committee
    Given a characteristic "egrid_subregion.abbreviation" of "<egrid>"
    And a characteristic "state.postal_abbreviation" of "<state>"
    And a characteristic "country.iso_3166_code" of "<country>"
    When the "loss_factor" committee reports
    Then the committee should have used quorum "<quorum>"
    And the conclusion of the committee should be "<lf>"
    Examples:
      | egrid | state | country | quorum               | lf     |
      | CAMX  |       |         | from eGRID subregion | 0.05   |
      |       | CA    |         | from state           | 0.048  |
      |       |       | US      | from country         | 0.0615 |
      |       |       | UM      | default              | 0.096  |
      |       |       |         | default              | 0.096  |

  Scenario Outline: Emission factor committee
    Given a characteristic "egrid_subregion.abbreviation" of "<egrid>"
    And a characteristic "state.postal_abbreviation" of "<state>"
    And a characteristic "country.iso_3166_code" of "<country>"
    When the "emission_factor" committee reports
    Then the committee should have used quorum "<quorum>"
    And the conclusion of the committee should be "<lf>"
    Examples:
      | egrid | state | country | quorum               | lf      |
      | CAMX  |       |         | from eGRID subregion | 0.31    |
      |       | CA    |         | from state           | 0.313   |
      |       |       | US      | from country         | 0.589   |
      |       |       | UM      | default              | 0.62609 |
      |       |       |         | default              | 0.62609 |

  Scenario Outline: Carbon committee
    Given a characteristic "date" of "<date>"
    And a characteristic "timeframe" of "<timeframe>"
    Given a characteristic "energy" of "<energy>"
    And a characteristic "emission_factor" of "<ef>"
    And a characteristic "loss_factor" of "<lf>"
    When the "date" committee reports
    And the "carbon" committee reports
    Then the committee should have used quorum "from date, emission factor, loss factor and energy"
    And the conclusion of the committee should be "<carbon>"
    Examples:
      | date       | timeframe             | energy | ef  | lf  | carbon |
      | 2010-07-15 | 2010-01-01/2011-01-01 | 3600   | 2.0 | 0.2 | 2500.0 |
      | 2011-07-15 | 2010-01-01/2011-01-01 | 3600   | 2.0 | 0.2 |    0.0 |
