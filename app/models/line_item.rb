class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :order, optional: true

  after_destroy_commit { broadcast_remove_to 'line_items' }
  after_update_commit { broadcast_replace_to 'line_items' }

  def total_price
    product.price * quantity
  end
end
