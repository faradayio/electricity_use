require 'emitter'

require 'electricity_use/impact_model'
require 'electricity_use/characterization'
require 'electricity_use/data'
require 'electricity_use/relationships'
require 'electricity_use/summarization'

module BrighterPlanet
  module ElectricityUse
    extend BrighterPlanet::Emitter
  end
end
