# frozen_string_literal: true

# TODO: We can add a base class to DRY out the code for both services
require 'net/http'
require 'uri'
require 'json'

# Get the 7 days of forecast of selected city
class ForecastApiClient
  def initialize(latitude:, longitude:)
    @latitude = latitude
    @longitude = longitude
    @base_url = Rails.application.credentials.dig(:forecast_api, :base_url)
  end

  def fetch_forecast
    response = Net::HTTP.get_response(build_uri)
    raise "API request failed with status code: #{response.code}" unless response.is_a?(Net::HTTPSuccess)

    forecast_of_days(response.body) if response.is_a?(Net::HTTPSuccess)
  rescue StandardError => e
    Rails.logger.error("Forecast API Error: #{e.message}")
    nil
  end

  private

  def build_uri
    uri = URI(@base_url)
    uri.query = URI.encode_www_form(
      latitude: @latitude,
      longitude: @longitude,
      daily: 'temperature_2m_max',
      timezone: 'auto'
    )
    uri
  end

  def forecast_of_days(response_body)
    forecast = JSON.parse(response_body)
    daily_forecast = forecast['daily']
    raise "Temperature can't be found" unless daily_forecast

    { date: daily_forecast['time'], temperature: daily_forecast['temperature_2m_max'] }
  end
end
