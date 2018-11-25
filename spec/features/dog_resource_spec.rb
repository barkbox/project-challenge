require 'rails_helper'

describe 'Dog resource', type: :feature do
  it 'can create a profile' do
    sign_in
    visit new_dog_path
    fill_in 'Name', with: 'Speck'
    fill_in 'Description', with: 'Just a dog'
    attach_file 'Images', 'spec/fixtures/images/speck.jpg', multiple: true
    click_button 'Create Dog'
    expect(Dog.count).to eq(1)
  end

  it 'can edit a dog profile' do
    dog = create(:dog)
    sign_in(dog.owner)
    visit edit_dog_path(dog)
    fill_in 'Name', with: 'Speck'
    click_button 'Update Dog'
    expect(dog.reload.name).to eq('Speck')
  end

  it 'can delete a dog profile' do
    dog = create(:dog)
    visit dog_path(dog)
    click_link "Delete #{dog.name}'s Profile"
    expect(Dog.count).to eq(0)
  end
end
