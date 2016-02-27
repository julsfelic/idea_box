require "rails_helper"

RSpec.feature "User can create an account" do
  scenario "they see their dashboard with a welcome message" do
    username = "julsfelic"

    visit root_path
    click_link "Register"
    fill_in "Username", with: username
    fill_in "Password", with: "password"
    click_button "Create Account"

    user = User.last

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content(username)
    within(".flash-success") do
      expect(page).to have_content("Welcome to the Idea Box Project")
    end
  end

  context "with invalid username" do
    scenario "they see an error message" do
      username = ""

      visit root_path
      click_link "Register"
      fill_in "Username", with: username
      fill_in "Password", with: "password"
      click_button "Create Account"

      expect(page).to_not have_content("Welcome to the Idea Box Project")
      within(".flash-error") do
        expect(page).to have_content("Invalid field(s). Please fill out form.")
      end
    end
  end
end
