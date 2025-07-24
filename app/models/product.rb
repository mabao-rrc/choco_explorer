# app/models/product.rb
class Product < ApplicationRecord
  belongs_to :brand
  has_many :reviews, dependent: :destroy
  has_many :product_categories
  has_many :categories, through: :product_categories
  has_many :country_products
  has_many :countries, through: :country_products

  validates :name, presence: true
  validates :ingredients, presence: true
end


