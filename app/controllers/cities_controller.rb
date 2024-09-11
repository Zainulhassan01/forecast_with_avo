# frozen_string_literal: true

# Showing the cities scrollbar and getting the forecast
class CitiesController < ApplicationController
  before_action :fetch_cities

  def index; end

  def forecast
    city = City.find_by(id: params[:city_id])
    @forecast = ForecastApiClient.new(latitude: city.latitude, longitude: city.longitude).fetch_forecast if city

    render :index
  end

  private

  def fetch_cities
    @cities = City.all
  end
end
