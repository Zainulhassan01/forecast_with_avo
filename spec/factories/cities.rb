# frozen_string_literal: true

# spec/factories/cities.rb
FactoryBot.define do
  factory :city do
    name { 'Sample City' }
    state { 'Sample' }
    latitude { 12.34 }
    longitude { 56.78 }
  end
end
