class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :dogs
  has_many :likes

  def owner_of?(dog)
    id == dog.user_id
  end

  def likes?(dog)
    dog.likes.where(user_id: id).any?
  end
end
