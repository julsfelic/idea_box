require "rails_helper"

RSpec.feature "User can login" do
  scenario "they see their dashboard" do
    user = FactoryGirl.create(:user)

    visit root_path
    click_link "Login"
    fill_in "Username", with: user.username
    fill_in "Password", with: "password"
    click_button "Login"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content(user.username)
    within(".site-header") do
      expect(page).to have_link("Logout")
    end
    expect(page).to_not have_link("Login")
  end

  context "with an invalid username" do
    scenario "they see an error message" do
      user = FactoryGirl.create(:user)
      invalid_username = "#{user.username} - invalid"

      visit root_path
      click_link "Login"
      fill_in "Username", with: invalid_username
      fill_in "Password", with: "password"
      click_button "Login"

      expect(page).to_not eq(user_path(user))
      expect(page).to_not have_content(user.username)
      within(".site-header") do
        expect(page).to have_link("Login")
      end
      expect(page).to_not have_link("Logout")
      within(".flash-error") do
        expect(page).to have_content("Invalid login info")
      end
    end
  end
end
