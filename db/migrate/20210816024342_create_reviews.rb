class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :item_id
      t.integer :rate
      t.text :text

      t.timestamps
    end
  end
end
