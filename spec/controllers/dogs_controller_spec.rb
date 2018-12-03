require 'rails_helper'

RSpec.describe DogsController, type: :controller do
  describe '#index' do
    before(:each) do
      user = User.new({ id: 1, email: "test@bark.co", password: "123456" })
      user.save
      allow(controller).to receive(:current_user).and_return(user)
    end

    it 'displays recent dogs' do
      2.times { create(:dog) }
      get :index
      expect(assigns(:dogs).size).to eq(2)
    end

    it 'displays a max of 5 dogs' do
      11.times { create(:dog) }
      get :index
      expect(assigns(:dogs).size).to eq(5)
    end

    it 'displays the second page of dogs' do
      8.times { create(:dog) }
      get :index, params: { page: '2' }
      expect(assigns(:dogs).size).to eq(3)
    end

    it 'saves the user_id when created' do
      get :create, params: { dog: { name: 'Doggo' } }
      expect(assigns(:dog).user_id).to eq(1)
    end

    it 'redirects to 404 if attempting to edit unowned dog' do
      create(:dog)
      get :edit, params: { id: 1 }
      response.should redirect_to "/404"
    end
  end
end
