require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  describe '#create' do
    it 'can like a dog' do
      dog = create(:dog)
      other_user = create(:user)
      sign_in other_user
      post :create, :params => { :dog_id => dog.id, :user_id => other_user.id }
      expect(Like.all.count).to eq(1)
    end

    it 'cannot like a dog own dog' do
      dog = create(:dog)
      user = dog.user
      sign_in user
      post :create, :params => { :dog_id => dog.id, :user_id => user.id }
      expect(Like.all.count).to eq(0)
    end
  end
end
