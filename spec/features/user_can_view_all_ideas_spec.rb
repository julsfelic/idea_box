require "rails_helper"

RSpec.feature "User can view all ideas" do
  scenario "they see their ideas" do
    user = create(:user_with_ideas)
    login(user)

    visit user_path(user)
    click_link "My Ideas"

    expect(current_path).to eq(user_ideas_path(user))
    user.ideas.each do |idea|
      within(".ideas") do
        expect(page).to have_content(idea.name)
        expect(page).to have_content(idea.description)
      end
    end
  end

  context "with other users having ideas" do
    scenario "they do not see the other users ideas" do
      user = create(:user_with_ideas)
      other_user = create(:user_with_idea)
      other_idea = other_user.ideas.last
      login(user)

      visit user_path(user)
      click_link "My Ideas"

      within(".ideas") do
        expect(page).to_not have_content(other_idea.name)
        expect(page).to_not have_content(other_idea.description)
      end
    end
  end
end
