class AddUserToDogs < ActiveRecord::Migration[5.2]
  def change
    add_column :dogs, :user_id, :integer
  end
end
