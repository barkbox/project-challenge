require 'rails_helper'

describe 'Dog resource', type: :feature do
  let!(:dog_owner){create(:user)}
  let!(:other_user){create(:user)}

  it 'can create a profile id signed in' do
    sign_in dog_owner
    visit new_dog_path
    fill_in 'Name', with: 'Speck'
    fill_in 'Description', with: 'Just a dog'
    attach_file 'Image', 'spec/fixtures/images/speck.jpg'
    click_button 'Create Dog'
    expect(Dog.count).to eq(1)
  end

  it 'can edit a dog profile if owner' do
    dog = create(:dog, user: dog_owner)
    sign_in dog_owner
    visit edit_dog_path(dog)
    fill_in 'Name', with: 'Speck'
    click_button 'Update Dog'
    expect(dog.reload.name).to eq('Speck')
  end

  it 'cannot edit a dog profile if not owner' do
    dog = create(:dog, user: dog_owner)
    sign_in other_user
    visit dog_path(dog)
    expect(page).not_to have_content( "Edit #{dog.name}'s Profile")
  end

  it 'can delete a dog profile if owner' do
    dog = create(:dog, user: dog_owner)
    sign_in dog_owner
    visit dog_path(dog)
    click_link "Delete #{dog.name}'s Profile"
    expect(Dog.count).to eq(0)
  end

  it 'cannot delete a dog profile if not owner' do
    dog = create(:dog, user: dog_owner)
    sign_in other_user
    visit dog_path(dog)
    expect(page).not_to have_content( "Delete #{dog.name}'s Profile")
  end
end
