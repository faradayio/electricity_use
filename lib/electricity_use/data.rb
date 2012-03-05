module BrighterPlanet
  module ElectricityUse
    module Data
      def self.included(base)
        base.col :date, :type => :date
        base.col :energy, :type => :float
        base.col :zip_code_name
        base.col :state_postal_abbreviation
        base.col :country_iso_3166_code
      end
    end
  end
end