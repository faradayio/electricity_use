require 'summary_judgement'

module BrighterPlanet
  module ElectricityUse
    module Summarization
      def self.included(base)
        base.extend SummaryJudgement
        base.summarize do |has|
          has.verb :use
          has.aspect :perfect
        end
      end
    end
  end
end
