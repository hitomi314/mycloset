class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.references :item, foreign_key: true
      t.integer :rate
      t.string :name
      t.string :brand
      t.text :text

      t.timestamps
    end
  end
end
