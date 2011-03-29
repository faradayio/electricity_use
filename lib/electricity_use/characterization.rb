module BrighterPlanet
  module ElectricityUse
    module Characterization
      def self.included(base)
        base.characterize do
          has :date
          has :energy
          has :zip_code
        end
      end
    end
  end
end
