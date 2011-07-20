module BrighterPlanet
  module ElectricityUse
    module Data
      def self.included(base)
        base.force_schema do
          date    'date'
          float   'energy'
          string  'zip_code_name'
        end
      end
    end
  end
end
