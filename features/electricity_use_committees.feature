Feature: Electricity Use Committee Calculations
  The electricity use model should generate correct committee calculations

  Background:
    Given a electricity_use

  Scenario: Date committee from timeframe
    Given a characteristic "timeframe" of "2010-07-15/2010-07-20"
    When the "date" committee reports
    Then the conclusion of the committee should be "2010-07-15"

  Scenario: Energy from nothing
    When the "energy" committee reports
    Then the committee should have used quorum "default"
    And the conclusion of the committee should be "39744"

  Scenario: eGRID subregion from nothing
    When the "egrid_subregion" committee reports
    Then the committee should have used quorum "default"
    And the conclusion of the committee should have "name" of "fallback"

  Scenario: eGRID subregion from zip code
    Given a characteristic "zip_code.name" of "94122"
    When the "egrid_subregion" committee reports
    Then the committee should have used quorum "from zip code"
    And the conclusion of the committee should have "abbreviation" of "CAMX"

  Scenario: Loss factor from default eGRID subregion
    When the "egrid_subregion" committee reports
    And the "loss_factor" committee reports
    Then the committee should have used quorum "from eGRID subregion"
    And the conclusion of the committee should be "0.0575"

  Scenario: Emission factor from default eGRID subregion
    When the "egrid_subregion" committee reports
    And the "emission_factor" committee reports
    Then the committee should have used quorum "from eGRID subregion"
    And the conclusion of the committee should be "0.75"
