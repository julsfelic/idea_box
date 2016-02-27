require "rails_helper"

RSpec.feature "User can logout" do
  scenario "they are directed to the home page with a message" do
    user = FactoryGirl.create(:user)
    login(user)

    click_link "Logout"

    expect(current_path).to eq(root_path)
    within(".flash-notice") do
      expect(page).to have_content("You have successfully logged out")
    end
    within(".site-header") do
      expect(page).to have_link("Login")
    end
  end
end
