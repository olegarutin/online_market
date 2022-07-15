class CreateMarkets < ActiveRecord::Migration[7.0]
  def change
    create_table :markets do |t|
      t.string :title
      t.text :description
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end
