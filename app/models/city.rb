# frozen_string_literal: true

# City Model with attributes to save data in DB
class City < ApplicationRecord
  before_validation :fetch_coordinates, on: :create

  private

  def fetch_coordinates
    return unless latitude.blank? && longitude.blank?

    coordinates = GeocodeApiClient.new(city: name, state:).fetch_city_coordinates
    if coordinates[:latitude].present? && coordinates[:longitude].present?
      self.latitude = coordinates[:latitude]
      self.longitude = coordinates[:longitude]
    else
      errors.add(:base, 'Could not fetch coordinates for the city.')
    end
  end
end
