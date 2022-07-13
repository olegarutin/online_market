class Category < ApplicationRecord
  belongs_to :market
  has_many :products
end
