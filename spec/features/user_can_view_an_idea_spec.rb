require "rails_helper"

RSpec.feature "User can view an idea" do
  scenario "they see the individual idea" do
    user = FactoryGirl.create(:user_with_idea)
    login(user)
    idea = user.ideas.last

    visit idea_path(idea)

    expect(page).to have_content(idea.name)
    expect(page).to have_content(idea.description)
  end
end
