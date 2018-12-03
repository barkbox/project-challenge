require "rails_helper"

RSpec.feature "Home page", :skip => "Unsure how to test js page", :type => :feature do
  scenario "New user lands on site" do
    2.times { create(:dog) }

    visit "/"

    # expect(page).to have_selector('.dog-photo', count: 2)
    expect(page).to have_selector('.dog-name', count: 2)
    # expect(page).to have_selector('.ad', count: 1)

    expect(page).to have_text("Sign in")
    expect(page).to have_text("Sign up")
  end
end
