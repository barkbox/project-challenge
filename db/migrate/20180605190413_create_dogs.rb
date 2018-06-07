class CreateDogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dogs do |t|
      t.string :name
      t.timestamp :birthday
      t.timestamp :adoption_date
      t.text :description
      t.timestamps
    end
  end
end
