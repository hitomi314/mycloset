class CreateRelatedItems < ActiveRecord::Migration[5.2]
  def change
    create_table :related_items do |t|
      t.references :item, foreign_key: true
      t.integer :parentitem_id

      t.timestamps
    end
  end
end
