# frozen_string_literal: true

# City helper for views
module CitiesHelper
  def forecast_table_rows(forecast)
    return '' unless forecast

    forecast[:date].zip(forecast[:temperature]).map do |date, temperature|
      content_tag(:tr) do
        concat content_tag(:td, date)
        concat content_tag(:td, "#{temperature}°C")
      end
    end.join.html_safe
  end
end
