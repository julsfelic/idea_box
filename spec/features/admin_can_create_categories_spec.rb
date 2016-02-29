require 'rails_helper'

RSpec.feature "Admin can create categories" do
  scenario "they see categories they have created" do
    admin = User.create(username: "kimikimi", password: "password", role: 1)
    login(admin)

    visit new_admin_category_path
    fill_in "Name", with: "Websites"
    click_on "Create Category"

    expect(admin_categories_path).to eq(current_path)
    expect(page).to have_content "Websites was created!"
    within ".categories" do
      expect(page).to have_content "Websites"
    end
  end

  context "default user does not see categories index" do
    scenario "they see an error message on categories path" do
      user = FactoryGirl.create(:user)
      login(user)

      visit admin_categories_path
      expect(page).to_not have_content "All Categories"
      expect(page).to have_content "The page you were looking for doesn't exist."
    end
  end
end
