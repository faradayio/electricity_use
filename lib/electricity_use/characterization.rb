module BrighterPlanet
  module ElectricityUse
    module Characterization
      def self.included(base)
        base.characterize do
          has :date
          has :energy, :measures => Measurement::ElectricalEnergy
          has :zip_code
          has :state
          has :country
        end
      end
    end
  end
end
