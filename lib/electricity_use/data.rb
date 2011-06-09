require 'data_miner'

module BrighterPlanet
  module ElectricityUse
    module Data
      def self.included(base)
        base.create_table do
          date    'date'
          float   'energy'
          string  'zip_code_name'
        end
      end
    end
  end
end
