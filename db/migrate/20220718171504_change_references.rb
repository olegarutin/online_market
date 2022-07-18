class ChangeReferences < ActiveRecord::Migration[7.0]
  def change
    remove_reference :line_items, :order, foreign_key: true
    add_reference :carts, :order, foreign_key: true
  end
end
