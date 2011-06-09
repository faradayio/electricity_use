require 'active_record'
require 'falls_back_on'
require 'electricity_use'
require 'sniff'

class ElectricityUseRecord < ActiveRecord::Base
  include Sniff::Emitter
  include BrighterPlanet::ElectricityUse
end
