require "rails_helper"

RSpec.feature "User can edit an idea" do
  scenario "they see the updated idea" do
    user = FactoryGirl.create(:user_with_idea)
    login(user)
    idea = user.ideas.last
    new_name = "New idea"
    new_description = "New description"

    visit idea_path(idea)
    click_link "Edit Idea"
    fill_in "Name", with: new_name
    fill_in "Description", with: new_description
    click_button "Save Edits"

    expect(current_path).to eq(idea_path(idea))
    within(".flash-success") do
      expect(page).to have_content("Idea successfully updated!")
    end
    expect(page).to have_content(new_name)
    expect(page).to have_content(new_description)
  end

  context "with empty name" do
    scenario "they see an error message" do
      user = FactoryGirl.create(:user_with_idea)
      login(user)
      idea = user.ideas.last
      invalid_name = ""
      new_description = "New Description"

      visit idea_path(idea)
      click_link "Edit Idea"
      fill_in "Name", with: invalid_name
      fill_in "Description", with: new_description
      click_button "Save Edits"

      within(".flash-error") do
        expect(page).to have_content("Name cannot be blank.")
      end
    end
  end
end
