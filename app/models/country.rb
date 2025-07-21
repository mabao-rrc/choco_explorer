# app/models/country.rb
class Country < ApplicationRecord
  has_many :country_products
  has_many :products, through: :country_products

  validates :name, presence: true, uniqueness: true
end

