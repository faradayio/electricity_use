module BrighterPlanet
  module ElectricityUse
    module Relationships
      def self.included(target)
        target.belongs_to :zip_code, :foreign_key => 'zip_code_name'
      end
    end
  end
end
