module BrighterPlanet
  module ElectricityUse
    module Characterization
      def self.included(base)
        base.send :include, Characterizable
        base.characterize do
          has :date
          has :energy
          has :zip_code
        end
      end
    end
  end
end