require 'earth/locality/country'
require 'earth/locality/state'
require 'earth/locality/zip_code'

module BrighterPlanet
  module ElectricityUse
    module Relationships
      def self.included(target)
        target.belongs_to :zip_code, :foreign_key => 'zip_code_name'
        target.belongs_to :state,    :foreign_key => 'state_postal_abbreviation'
        target.belongs_to :country,  :foreign_key => 'country_iso_3166_code'
      end
    end
  end
end
