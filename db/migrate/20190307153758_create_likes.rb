class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :dog_id, null: false
      t.integer :liker_id, null: false

      t.timestamps
    end

    add_index :likes, [:liker_id, :dog_id], unique: true
    add_index :likes, :liker_id
    add_index :likes, :dog_id
  end
end
