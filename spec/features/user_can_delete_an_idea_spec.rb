require "rails_helper"

RSpec.feature "User can delete an idea" do
  scenario "they do not see the idea on the user ideas page" do
    user = create(:user_with_ideas)
    login(user)
    idea_to_delete = user.ideas.last

    visit user_ideas_path(user)
    click_link idea_to_delete.name
    click_link "Delete Idea"

    expect(current_path).to eq(user_ideas_path(user))
    within(".flash-notice") do
      expect(page).to have_content("#{idea_to_delete.name} has been deleted.")
    end
    within(".ideas") do
      expect(page).to_not have_content(idea_to_delete.name)
      expect(page).to_not have_content(idea_to_delete.description)
    end
  end
end
