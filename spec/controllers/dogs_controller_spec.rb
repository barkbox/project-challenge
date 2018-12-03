require 'rails_helper'

RSpec.describe DogsController, type: :controller do
  describe '#index' do
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
  end
end
