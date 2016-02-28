require "rails_helper"

RSpec.feature "User can create an idea" do
  scenario "they see the page for the newly created idea" do
    user = FactoryGirl.create(:user)
    login(user)

    visit user_path(user)
    click_link "New Idea"
    fill_in "Name", with: "Taking over the world!"
    fill_in "Description", with: "One step at a time"
    click_button "Create Idea"

    idea = user.ideas.last

    expect(current_path).to eq(idea_path(idea))
    within(".idea") do
      expect(page).to have_content(idea.description)
    end
  end
end
