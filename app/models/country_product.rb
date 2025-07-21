# app/models/country_product.rb
class CountryProduct < ApplicationRecord
  belongs_to :product
  belongs_to :country
end
