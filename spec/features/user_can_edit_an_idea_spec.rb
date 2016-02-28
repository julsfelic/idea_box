require "rails_helper"

RSpec.feature "User can edit an idea" do
  scenario "they see the updated idea" do
    user = FactoryGirl.create(:user_with_idea)
    login(user)
    idea = user.ideas.last
    new_idea = "New idea"
    new_description = "New description"

    visit idea_path(idea)
    click_link "Edit Idea"
    fill_in "Name", with: new_idea
    fill_in "Description", with: new_description
    click_button "Save Edits"

    expect(current_path).to eq(idea_path(idea))
    within(".flash-success") do
      expect(page).to have_content("Idea successfully updated!")
    end
    expect(page).to have_content(new_idea)
    expect(page).to have_content(new_description)
  end
end
