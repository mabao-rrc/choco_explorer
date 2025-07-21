# app/models/product.rb
class Product < ApplicationRecord
  belongs_to :brand
  has_many :product_categories
  has_many :categories, through: :product_categories
  has_many :country_products
  has_many :countries, through: :country_products
  has_many :reviews
end

