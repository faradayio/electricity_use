module BrighterPlanet
  module ElectricityUse
    module Data
      def self.included(base)
        base.col :date, :type => :date
        base.col :energy, :type => :float
        base.col :zip_code_name
      end
    end
  end
end