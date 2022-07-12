class Market < ApplicationRecord
  has_many :categories, dependent: :destroy
end
