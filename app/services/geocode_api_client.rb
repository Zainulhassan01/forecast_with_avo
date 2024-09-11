# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

# get latitude and longitude for city
class GeocodeApiClient
  def initialize(city:, state:)
    @city = city
    @state = state
    @base_url = ENV['GEOCODE_API_BASE_URL']
    @api_key = ENV['GEOCODE_API_KEY']
  end

  def fetch_city_coordinates
    response = Net::HTTP.get_response(build_uri)
    raise "API request failed with status code: #{response.code}" unless response.is_a?(Net::HTTPSuccess)

    get_latitude_and_longitude(response.body) if response.is_a?(Net::HTTPSuccess)
  rescue StandardError => e
    Rails.logger.error("Geocode API Error: #{e.message}")
    {}
  end

  private

  def build_uri
    uri = URI(@base_url)
    uri.query = URI.encode_www_form(
      city: @city,
      state: @state,
      api_key: @api_key
    )
    uri
  end

  def get_latitude_and_longitude(response_body)
    result = JSON.parse(response_body)&.first
    raise "No coordinates found for #{@city}, #{@state}" unless result

    { latitude: result['lat'].to_f, longitude: result['lon'].to_f }
  end
end
