class CreateRelatedItems < ActiveRecord::Migration[5.2]
  def change
    create_table :related_items do |t|
      t.integer :item_id

      t.timestamps
    end
  end
end
