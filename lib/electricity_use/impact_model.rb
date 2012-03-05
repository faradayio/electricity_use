# Copyright © 2010 Brighter Planet.
# See LICENSE for details.
# Contact Brighter Planet for dual-license arrangements.

## Electricity use model
# This model is used by the [Brighter Planet](http://brighterplanet.com) [CM1 web service](http://impact.brighterplanet.com) to calculate the impacts of electricity consumption, such as energy use, greenhouse gas emissions, and water use.

##### Timeframe
# The model calculates impacts that occured during a particular time period (`timeframe`).
# For example if the `timeframe` is February 2010, an electricity use that occurred (`date`) on February 15, 2010 will have impacts, but an electricity use that occurred on January 31, 2010 will have zero impacts.
#
# The default `timeframe` is the current calendar year.

##### Calculations
# The final impacts are the result of the calculations below. These are performed in reverse order, starting with the last calculation listed and finishing with the greenhouse gas emissions calculation.
#
# Each calculation listing shows:
#
# * value returned (*units of measurement*)
# * description of the value
# * calculation methods, listed from most to least preferred
#
# Some methods use `values` returned by prior calculations. If any of these `values` are unknown the method is skipped.
# If all the methods for a calculation are skipped, the value the calculation would return is unknown.

##### Standard compliance
# When compliance with a particular standard is requested, all methods that do not comply with that standard are ignored.
# Thus any `values` a method needs will have been calculated using a compliant method or will be unknown.
# To see which standards a method complies with, look at the `:complies =>` section of the code in the right column.
#
# Client input complies with all standards.

##### Collaboration
# Contributions to this impact model are actively encouraged and warmly welcomed. This library includes a comprehensive test suite to ensure that your changes do not cause regressions. All changes should include test coverage for new functionality. Please see [sniff](https://github.com/brighterplanet/sniff#readme), our emitter testing framework, for more information.
module BrighterPlanet
  module ElectricityUse
    module ImpactModel
      def self.included(base)
        base.decide :impact, :with => :characteristics do
          # * * *
          
          #### Carbon (*kg CO<sub>2</sub>e*)
          # *The electricity use's total anthropogenic greenhouse gas emissions during `timeframe`.*
          committee :carbon do
            # If `date` is in `timeframe`, convert `energy` (*MJ*) to *kWh* and divide by (1 - `loss factor`) to give total electricity use including transmission and distribution losses (*kWh*).
            # Multiply by `emission factor` (*kg CO<sub>2</sub>e / kWh*) to give *kg CO<sub>2</sub>e*.
            quorum 'from date, emission factor, loss factor and energy', :needs => [:date, :emission_factor, :loss_factor, :energy] do |characteristics, timeframe|
              date = characteristics[:date].is_a?(Date) ? characteristics[:date] : Date.parse(characteristics[:date].to_s)
              if timeframe.include? date
                characteristics[:energy].value.megajoules.to(:kilowatt_hours) / (1 - characteristics[:loss_factor]) * characteristics[:emission_factor]
              else
                0
              end
            end
          end
          
          #### Emission factor (*kg CO<sub>2</sub>e / kWh*)
          # *The average electricity emission factor of the area where the electricity was used.*
          committee :emission_factor do
            # Look up the `egrid subregion` electricity emission factor (*kg CO<sub>2</sub>e / kWh*).
            quorum 'from eGRID subregion', :needs => :egrid_subregion do |characteristics|
              characteristics[:egrid_subregion].electricity_emission_factor
            end
            
            # Otherwise look up the `state` electricity emission factor (*kg CO<sub>2</sub>e / kWh*).
            quorum 'from state', :needs => :state do |characteristics|
              characteristics[:state].electricity_emission_factor
            end
            
            # Otherwise look up the `country` electricity emission factor (*kg CO<sub>2</sub>e / kWh*).
            quorum 'from country', :needs => :country do |characteristics|
              characteristics[:country].electricity_emission_factor
            end
            
            # Otherwise use the global average electricity emission factor (*kg CO<sub>2</sub>e / kWh*).
            quorum 'default' do
              Country.fallback.electricity_emission_factor
            end
          end
          
          #### Loss factor
          # *The average transmission and distribution loss factor for the area where the electricity was used.*
          committee :loss_factor do
            # Look up the loss factor for the `egrid subregion` eGRID region.
            quorum 'from eGRID subregion', :needs => :egrid_subregion do |characteristics|
              characteristics[:egrid_subregion].egrid_region.loss_factor
            end
            
            # Otherwise look up the `state` electricity loss factor.
            quorum 'from state', :needs => :state do |characteristics|
              characteristics[:state].electricity_loss_factor
            end
            
            # Otherwise look up the `country` electricity loss factor.
            quorum 'from country', :needs => :country do |characteristics|
              characteristics[:country].electricity_loss_factor
            end
            
            # Otherwise use the global average electricity loss factor.
            quorum 'default' do
              Country.fallback.electricity_loss_factor
            end
          end
          
          #### Energy (*MJ*)
          # *The energy content of the electricity used.*
          committee :energy do
            # Use client input, if available.
            
            # Otherwise convert the 2010 U.S. [average annual household electricity use](http://www.eia.gov/tools/faqs/faq.cfm?id=97&t=3) from *kWh* to *MJ*.
            quorum 'default' do
              11_496.kilowatt_hours.to(:megajoules)
            end
          end
          
          #### Country
          # *The [country](http://data.brighterplanet.com/countries) where the electricity was used.*
          committee :country do
            # Use client input, if available.
            
            # Otherwise if we know `state` then country must be the United States.
            quorum 'from state', :needs => :state, do
              Country.united_states
            end
          end
          
          #### eGRID subregion
          # *The [eGRID subregion](http://data.brighterplanet.com/egrid_subregions) where the electricity was used.*
          committee :egrid_subregion do
            # Look up the `zip code` eGRID subregion.
            quorum 'from zip code', :needs => :zip_code do |characteristics|
              characteristics[:zip_code].egrid_subregion
            end
          end
          
          #### State
          # *The [US state](http://data.brighterplanet.com/states) where the electricity was used.*
          committee :state do
            # Use client input, if available.
            
            # Otherwise look up the `zip code` state.
            quorum 'from zip code', :needs => :zip_code do |characteristics|
              characteristics[:zip_code].state
            end
          end
          
          #### Zip code
          # *The [US zip code](http://data.brighterplanet.com/zip_codes) where the electricity was used.*
          #
          # Use client input, if available.
          
          #### Date (*date*)
          # *The day the electricity use occurred.*
          committee :date do
            # Use client input, if available.
            
            # Otherwise use the first day of `timeframe`.
            quorum 'from timeframe' do |characteristics, timeframe|
                timeframe.from
            end
          end
        end
      end
    end
  end
end
