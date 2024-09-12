# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
City.create([
              { name: 'Karachi', state: 'Sindh', latitude: 24.8546842, longitude: 67.0207055 },
              { name: 'Lahore', state: 'Punjab', latitude: 31.5656822, longitude: 74.3141829 },
              { name: 'Murree', state: 'Punjab', latitude: 33.9056829, longitude: 73.392674 },
              { name: 'Islamabad', state: 'Punjab', latitude: 32.3769915, longitude: 73.9852458 },
              { name: 'Gujranwala', state: 'Punjab', latitude: 32.1525312, longitude: 74.1933745 },
              { name: 'New York', state: 'NY', latitude: 40.7127281, longitude: -74.0060152 }
            ])
