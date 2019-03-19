require 'rails_helper'

describe 'Dog resource', type: :feature do
  it 'can create a profile' do
    visit new_user_registration_path
    fill_in 'Email', with: 'testing2468@gmail.com'
    fill_in 'Password', with: 'starwars'
    fill_in 'Password confirmation', with: 'starwars'
    click_button 'Sign up'
    visit new_dog_path
    fill_in 'Name', with: 'Speck'
    fill_in 'Description', with: 'Just a dog'
    attach_file 'Image', 'spec/fixtures/images/speck.jpg'
    click_button 'Create Dog'
    expect(Dog.count).to eq(1)
  end

  it 'can edit a dog profile' do
    dog = create(:dog)
    visit edit_dog_path(dog)
    fill_in 'Name', with: 'Speck'
    click_button 'Update Dog'
    expect(dog.reload.name).to eq('Speck')
  end

  it 'can delete a dog profile' do
    visit new_user_registration_path
    fill_in 'Email', with: 'testing24689@gmail.com'
    fill_in 'Password', with: 'starwars'
    fill_in 'Password confirmation', with: 'starwars'
    click_button 'Sign up'
    visit new_dog_path
    fill_in 'Name', with: 'Speck'
    fill_in 'Description', with: 'Just a dog'
    attach_file 'Image', 'spec/fixtures/images/speck.jpg'
    click_button 'Create Dog'
    click_link "Delete Speck's Profile"
    expect(Dog.count).to eq(0)
  end
end
