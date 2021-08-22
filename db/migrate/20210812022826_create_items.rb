class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.references :style, foreign_key: true
      t.string :name, null: false
      t.string :brand
      t.string :color
      t.string :color_code
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
