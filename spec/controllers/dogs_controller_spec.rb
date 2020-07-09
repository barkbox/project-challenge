require 'rails_helper'

RSpec.describe DogsController, type: :controller do
  describe '#index' do
    it 'limits recent dogs to 5' do
      6.times { create(:dog) }
      get :index
      expect(assigns(:dogs).size).to eq(5)
    end
  end
end
