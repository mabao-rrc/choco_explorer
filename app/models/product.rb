# app/models/product.rb
class Product < ApplicationRecord
  belongs_to :brand
end
