Feature: Electricity Use Committee Calculations
  The electricity use model should generate correct committee calculations

  Scenario: Date committee from timeframe
    Given an electricity use emitter
    And a characteristic "timeframe" of "2010-07-15/2010-07-20"
    When the "date" committee is calculated
    Then the conclusion of the committee should be "2010-07-15"

  Scenario: kWh from nothing
    Given an electricity use emitter
    When the "energy" committee is calculated
    Then the committee should have used quorum "default"
    And the conclusion of the committee should be "11040"

  Scenario: eGRID subregion from nothing
    Given an electricity use emitter
    When the "egrid_subregion" committee is calculated
    Then the committee should have used quorum "default"
    And the conclusion of the committee should have "abbreviation" of "US"

  Scenario: eGRID subregion from zip code
    Given an electricity use emitter
    And a characteristic "zip_code.name" of "94122"
    When the "egrid_subregion" committee is calculated
    Then the committee should have used quorum "from zip code"
    And the conclusion of the committee should have "abbreviation" of "CAMX"

  Scenario: Emission factor from eGRID subregion
    Given an electricity use emitter
    When the "egrid_subregion" committee is calculated
    And the "emission_factor" committee is calculated
    Then the committee should have used quorum "from eGRID subregion"
    And the conclusion of the committee should be "2.0"
