class CreateMarketsCategories < ActiveRecord::Migration[7.0]
  def change
    create_join_table :markets, :categories
  end
end
