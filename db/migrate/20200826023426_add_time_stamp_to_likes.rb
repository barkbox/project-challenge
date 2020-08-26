class AddTimeStampToLikes < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :likes, null: false, default: Time.now
  end
end
