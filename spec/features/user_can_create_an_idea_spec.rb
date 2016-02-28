require "rails_helper"

RSpec.feature "User can create an idea" do
  scenario "they see the page for the newly created idea" do
    user = FactoryGirl.create(:user)
    login(user)
    idea_name = "Taking over the world!"
    idea_description = "One step at a time"

    visit user_path(user)
    click_link "New Idea"
    fill_in "Name", with: idea_name
    fill_in "Description", with: idea_description
    click_button "Create Idea"

    idea = user.ideas.last

    expect(current_path).to eq(user_idea_path(user, idea))
    within(".idea") do
      expect(page).to have_content(idea_description)
    end
  end

  context "with no name" do
    scenario "they see an error message" do
      user = FactoryGirl.create(:user)
      login(user)
      invalid_idea_name = ""
      idea_description = "One step at a time"

      visit user_path(user)
      click_link "New Idea"
      fill_in "Name", with: invalid_idea_name
      fill_in "Description", with: idea_description
      click_button "Create Idea"

      expect(current_path).to eq(user_ideas_path(user.id))
      within(".flash-error") do
        expect(page).to have_content("Idea must have a name")
      end
    end
  end
end
