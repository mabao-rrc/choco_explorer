# app/models/brand.rb
class Brand < ApplicationRecord
  has_many :products
end
