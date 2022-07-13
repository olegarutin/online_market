class AddMissingReferences < ActiveRecord::Migration[7.0]
  def change
    add_reference :categories, :market, foreign_key: true
    add_reference :products, :category, foreign_key: true
    add_reference :carts, :user, foreign_key: true
    add_reference :line_items, :cart, foreign_key: true
    add_reference :line_items, :product, foreign_key: true
    add_reference :line_items, :order, foreign_key: true
    add_reference :orders, :user, foreign_key: true
  end
end
