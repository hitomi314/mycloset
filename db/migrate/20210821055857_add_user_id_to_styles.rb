class AddUserIdToStyles < ActiveRecord::Migration[5.2]
  def change
    add_column :styles, :user_id, :integer
  end
end
