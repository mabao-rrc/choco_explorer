# app/models/product_category.rb
class ProductCategory < ApplicationRecord
  belongs_to :product
  belongs_to :category
end
