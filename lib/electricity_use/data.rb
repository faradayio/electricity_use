require 'data_miner'

module BrighterPlanet
  module ElectricityUse
    module Data
      def self.included(base)
        base.data_miner do
          schema do
            float   'kwh'
            string  'state_postal_abbreviation'
            string  'zip_code_name'
          end
          
          process :run_data_miner_on_belongs_to_associations
        end
      end
    end
  end
end
