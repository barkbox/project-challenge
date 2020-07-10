require 'rails_helper'
require 'devise'

RSpec.describe DogsController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe '#index' do
    it 'limits recent dogs to 5' do
      6.times { create(:dog) }
      get :index
      expect(assigns(:dogs).size).to eq(5)
    end
  end
end
