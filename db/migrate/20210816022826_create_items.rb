class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :user_id
      t.integer :category_id
      t.integer :style_id
      t.string :name
      t.string :brand
      t.string :color
      t.integer :color_code
      t.integer :item_sex
      t.string :size
      t.string :material
      t.integer :season
      t.date :buy_day
      t.string :price

      t.timestamps
    end
  end
end
