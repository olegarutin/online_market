class Cart < ApplicationRecord
  IN_PROGRESS = :in_progress
  ORDERED = :ordered

  STATUSES = [IN_PROGRESS, ORDERED].freeze

  belongs_to :user
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  enum status: STATUSES

  def total_price
    line_items.map(&:total_price).sum
  end
end
