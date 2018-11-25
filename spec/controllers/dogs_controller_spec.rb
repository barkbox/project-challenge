require 'rails_helper'

RSpec.describe DogsController, type: :controller do
  describe '#index' do
    it 'displays recent dogs' do
      2.times { create(:dog) }
      get :index
      expect(assigns(:dogs).size).to eq(2)
    end
    
    it 'dipslays 5 dogs per page' do
      6.times { create(:dog) }
      get :index
      expect(assigns(:dogs).size).to eq(5)
    end
  end
  
  describe '#create' do
    it 'creates a new dog' do
      expect do
        post :create, params: {dog: {name: 'Fluffy', description: 'cute dog', images: [fixture_file_upload('images/speck.jpg', 'image/jpeg')]}}
      end.to change{ Dog.count }.by(1)
      expect(assigns['dog'].images.size).to eq(1)
    end
  end
  
  describe '#update' do
    it 'updates a existing dog' do
      dog = create(:dog)
      updated_name = dog.name + 'updated'
      patch :update, params: { id: dog.id, dog: {name: updated_name}}
      expect(assigns[:dog].name).to eq updated_name
    end
  end
end
