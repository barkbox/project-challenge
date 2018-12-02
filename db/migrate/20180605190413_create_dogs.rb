class CreateDogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dogs do |t|
      t.string :name
      t.timestamp :birthday
      t.timestamp :adoption_date
      t.timestamp :last_liked
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
