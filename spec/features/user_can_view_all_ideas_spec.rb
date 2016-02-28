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
end
