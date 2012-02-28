# Copyright © 2010 Brighter Planet.
# See LICENSE for details.
# Contact Brighter Planet for dual-license arrangements.
require 'leap'
require 'timeframe'
require 'date'
require 'weighted_average'
require 'builder'

## ElectricityUse carbon model
# This model is used by [Brighter Planet](http://brighterplanet.com)'s carbon emission [web service](http://carbon.brighterplanet.com) to estimate the **greenhouse gas emissions of electricity use**.
#
##### Timeframe and date
# The model estimates the emissions that occur during a particular `timeframe`. To do this it needs to know the `date` on which the electricity use occurred. For example, if the `timeframe` is January 2010, a electricity use that occurred on January 5, 2010 will have emissions but a electricity use that occurred on February 1, 2010 will not.
#
##### Calculations
# The final estimate is the result of the **calculations** detailed below. These calculations are performed in reverse order, starting with the last calculation listed and finishing with the `emission` calculation. Each calculation is named according to the value it returns.
#
##### Methods
# To accomodate varying client input, each calculation may have one or more **methods**. These are listed under each calculation in order from most to least preferred. Each method is named according to the values it requires. If any of these values is not available the method will be ignored. If all the methods for a calculation are ignored, the calculation will not return a value. "Default" methods do not require any values, and so a calculation with a default method will always return a value.
#
##### Standard compliance
# Each method lists any established calculation standards with which it **complies**. When compliance with a standard is requested, all methods that do not comply with that standard are ignored. This means that any values a particular method requires will have been calculated using a compliant method, because those are the only methods available. If any value did not have a compliant method in its calculation then it would be undefined, and the current method would have been ignored.
#
##### Collaboration
# Contributions to this carbon model are actively encouraged and warmly welcomed. This library includes a comprehensive test suite to ensure that your changes do not cause regressions. All changes should include test coverage for new functionality. Please see [sniff](https://github.com/brighterplanet/sniff#readme), our emitter testing framework, for more information.
module BrighterPlanet
  module ElectricityUse
    module ImpactModel
      def self.included(base)
        base.decide :impact, :with => :characteristics do
          ### Emission calculation
          # Returns the `emission` estimate (*kg CO<sub>2</sub>e*).
          # This is the emission produced by generating the electricity used during the `timeframe`, including transmission and distribution losses.
          committee :carbon do
            #### Emission from date, emission factor, loss factor, and energy
            quorum 'from date, emission factor, loss factor and energy', :needs => [:date, :emission_factor, :loss_factor, :energy] do |characteristics, timeframe|
              date = characteristics[:date].is_a?(Date) ?
                characteristics[:date] :
                Date.parse(characteristics[:date].to_s)
              # - Checks whether the electricity was used during the `timeframe`
              if timeframe.include? date
                # - Converts `energy` (*MJ*) to *kWh* and divides by (1 - `loss factor`) to give total electricity used, including transmission and distribution losses (*kWh*)
                # - Multiplies by `emission factor` (*kg CO<sub>2</sub>e / kWh*) to give emission (*kg CO<sub>2</sub>e*)
                characteristics[:energy].megajoules.to(:kilowatt_hours) / (1 - characteristics[:loss_factor]) * characteristics[:emission_factor]
              else
                # - If the electricity was not used during the `timeframe`, `emission` is zero
                0
              end
            end
          end
          
          ### Emission factor calculation
          # Returns the grid average emission factor of the area where the electricity was used (*kg CO<sub>2</sub> / kWh*).
          committee :emission_factor do
            #### Emission factor from eGRID subregion
            quorum 'from eGRID subregion', :needs => :egrid_subregion do |characteristics|
              # Looks up the emission factor of the `eGRID subregion`.
              characteristics[:egrid_subregion].electricity_emission_factor
            end
          end
          
          ### Loss factor calculation
          # Returns the average transmission and distribution loss factor for the area where the electricity was used.
          committee :loss_factor do
            #### Loss factor from eGRID subregion
            quorum 'from eGRID subregion', :needs => :egrid_subregion do |characteristics|
              # Looks up the loss factor of the `eGRID subregion` [eGRID region](http://data.brighterplanet.com/egrid_regions).
              characteristics[:egrid_subregion].egrid_region.loss_factor
            end
          end
          
          ### eGRID subregion calculation
          # Returns the [eGRID subregion](http://data.brighterplanet.com/egrid_subregions) where the electricity was used.
          committee :egrid_subregion do
            #### eGRID subregion from zip code
            quorum 'from zip code', :needs => :zip_code do |characteristics|
              # Looks up the [eGRID subregion](http://data.brighterplanet.com/egrid_subregions) in which the `zip code` is located.
              characteristics[:zip_code].egrid_subregion
            end
            
            ##### eGRID subregion from default
            quorum 'default' do
              # Uses the average of all [eGRID subregion](http://data.brighterplanet.com/egrid_subregions), weighted by electricity generation.
              EgridSubregion.fallback
            end
          end
          
          ### Energy calculation
          # Returns the electricity used (*MJ*).
          committee :energy do
            #### Energy use from client input
            # Uses the client-input `energy` (*MJ*).
            
            #### Energy from default
            quorum 'default' do
              # Uses the 2008 U.S. [annual household average electricity use](http://www.eia.doe.gov/ask/electricity_faqs.asp#electricity_use_home) (*MJ*).
              11_040.kilowatt_hours.to(:megajoules)
            end
          end
          
          ### Date calculation
          # Returns the `date` on which the electricity was used.
          committee :date do
            #### Date from client input
            # Uses the client-input `date`.
            
            #### Date from timeframe
            quorum 'from timeframe' do |characteristics, timeframe|
                # Assumes the electricity was used on the first day of the `timeframe`.
                timeframe.from
            end
          end
          
          ### Zip code calculation
          # Returns the [zip code](http://data.brighterplanet.com/zip_codes) where the electricity was used.
            #### Zip code from client input
            # Uses the client-input [zip code](http://data.brighterplanet.com/zip_codes).
          
          ### Timeframe calculation
          # Returns the `timeframe` during which to calculate emissions.
            #### Timeframe from client input
            # Uses the client-input `timeframe`.
        end
      end
    end
  end
end
