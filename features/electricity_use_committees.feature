Feature: Electricity Use Committee Calculations
  The electricity use model should generate correct committee calculations

  Background:
    Given a electricity_use

  Scenario: Date committee from timeframe
    Given a characteristic "timeframe" of "2010-07-15/2010-07-20"
    When the "date" committee reports
    Then the conclusion of the committee should be "2010-07-15"

  Scenario: Energy from nothing
    Given the conclusion of the committee should be "11040"

  Scenario: eGRID subregion from nothing
    Given the conclusion of the committee should have "abbreviation" of "US"

  Scenario: eGRID subregion from zip code
    Given a characteristic "zip_code.name" of "94122"
    When the "egrid_subregion" committee reports
    Then the committee should have used quorum "from zip code"
    And the conclusion of the committee should have "abbreviation" of "CAMX"

  Scenario: eGRID region from nothing
    Given the "egrid_region" committee reports
    Then the committee should have used quorum "from eGRID subregion"
    And the conclusion of the committee should have "name" of "US"

  Scenario: eGRID region from zip code
    Given a characteristic "zip_code.name" of "94122"
    When the "egrid_subregion" committee reports
    And the "egrid_region" committee reports
    Then the committee should have used quorum "from eGRID subregion"
    And the conclusion of the committee should have "name" of "W"

  Scenario: Loss factor from eGRID region
    Given the "egrid_region" committee reports
    And the "loss_factor" committee reports
    Then the committee should have used quorum "from eGRID region"
    And the conclusion of the committee should be "0.2"

  Scenario: Emission factor from eGRID subregion
    Given the "emission_factor" committee reports
    Then the committee should have used quorum "from eGRID subregion"
    And the conclusion of the committee should be "2.0"
