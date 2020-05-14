require 'rails_helper'

RSpec.describe DogsController, type: :controller do
  describe '#index' do
    it 'displays recent dogs' do
      2.times { create(:dog) }
      get :index
      expect(assigns(:dogs).size).to eq(2)
    end

    it 'displays 5 dogs before pagination' do
      6.times { create(:dog) }
      get :index
      expect(assigns(:dogs).size).to eq(5)
    end

    it 'can sort dogs by likes' do
      6.times { create(:dog) }
      get :index, :params => {:sort_by_likes => true}
      expect(assigns(:dogs).size).to eq(5)
    end
  end
end
