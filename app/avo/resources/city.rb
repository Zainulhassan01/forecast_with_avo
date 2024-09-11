# frozen_string_literal: true

module Avo
  module Resources
    # Resource class to map city to Avo
    class City < Avo::BaseResource
      def fields
        field :name, as: :text
        field :state, as: :text
        field :latitude, as: :number
        field :longitude, as: :number
      end
    end
  end
end
