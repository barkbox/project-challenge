class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :dog_id
      t.integer :user_id
      t.timestamps
    end
  end
end
