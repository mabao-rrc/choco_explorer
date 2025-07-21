# app/models/country_product.rb
class CountryProduct < ApplicationRecord
  belongs_to :product
  belongs_to :country

  validates :product_id, presence: true
  validates :country_id, presence: true
end

