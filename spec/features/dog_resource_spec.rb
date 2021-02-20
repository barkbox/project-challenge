require 'rails_helper'
require_relative '../support/devise'

describe 'Dog resource', type: :feature do
  let!(:spec_user) { User.first || FactoryBot.create(:user) }
  before { login_as spec_user }

  it 'can create a profile' do
    visit new_dog_path
    fill_in 'Name', with: 'Speck'
    fill_in 'Description', with: 'Just a dog'
    attach_file 'Image', 'spec/fixtures/images/speck.jpg'
    click_button 'Create Dog'
    expect(Dog.count).to eq(1)
  end

  it 'can edit a dog profile' do
    dog = create(:dog, user: spec_user)
    visit edit_dog_path(dog)
    fill_in 'Name', with: 'Speck'
    click_button 'Update Dog'
    expect(dog.reload.name).to eq('Speck')
  end

  it 'can delete a dog profile' do
    dog = create(:dog, user: spec_user)
    visit dog_path(dog)
    click_link "Delete #{dog.name}'s Profile"
    expect(Dog.count).to eq(0)
  end
end
