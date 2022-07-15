class Product < ApplicationRecord
  has_and_belongs_to_many :markets
  has_many :line_items, dependent: :destroy
end
