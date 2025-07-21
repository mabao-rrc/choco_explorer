class CountryProduct < ApplicationRecord
  belongs_to :product
  belongs_to :country
end
