# frozen_string_literal: true

require 'rails_helper'
RSpec.describe CitiesController, type: :controller do
  render_views

  let(:city) { create(:city) }
  let(:valid_params) { { city: { city_id: city.id } } }
  let(:forecast_data) do
    {
      date: %w[2024-09-01 2024-09-02],
      temperature: [25, 22]
    }
  end

  before do
    allow_any_instance_of(ForecastApiClient).to receive(:fetch_forecast).and_return(forecast_data)
  end

  describe 'GET #index' do
    it 'assigns cities and renders the index template' do
      get :index

      expect(response).to have_http_status(:success)
      expect(response.body).to include('Select a City')
    end
  end

  describe 'POST #forecast' do
    context 'when city exists' do
      it 'fetches the forecast and assigns forecast' do
        post :forecast, params: valid_params

        expect(response).to have_http_status(:success)
        expect(response.body).to include('2024-09-01')
        expect(response.body).to include('25°C')
      end
    end

    context 'when city does not exist' do
      it 'renders the index template with no forecast' do
        post :forecast, params: { city: { city_id: -1 } }

        expect(response).to have_http_status(:success)
        expect(response.body).not_to include('2024-09-01')
      end
    end
  end
end
