class CreateProducts < ActiveRecord::Migration[6.1]
  # drop old table manually as needed
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price
      t.string :category
      t.text :description
      t.string :image
      t.decimal :rating_rate
      t.integer :rating_count

      t.timestamps
    end
  end
end
