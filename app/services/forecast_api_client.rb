# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

# get the last 7 days of forecast of selected city
class ForecastApiClient
  def initialize(latitude:, longitude:)
    @latitude = latitude
    @longitude = longitude
    @base_url = Rails.application.config.forecast_api.base_url
  end

  def fetch_forecast
    response = Net::HTTP.get_response(build_uri)
    raise "API request failed with status code: #{response.code}" unless response.is_a?(Net::HTTPSuccess)

    last_days_forecast(response.body) if response.is_a?(Net::HTTPSuccess)
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

  def last_days_forecast(response_body)
    forecast = JSON.parse(response_body)
    daily_forecast = forecast['daily']
    raise "Temperature can't be found" unless daily_forecast

    { date: daily_forecast['time'], temperature: daily_forecast['temperature_2m_max'] }
  end
end
