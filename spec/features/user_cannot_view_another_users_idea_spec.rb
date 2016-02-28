require "rails_helper"

RSpec.feature "User cannot view another users idea" do
  scenario "they are redirected to their dashboard" do
    logged_in_user = create(:user)
    login(logged_in_user)
    other_user = create(:user_with_idea)
    other_user_idea = other_user.ideas.last

    visit user_idea_path(other_user, other_user_idea)

    expect(current_path).to_not eq(user_idea_path(other_user, other_user_idea))
    expect(current_path).to eq(user_path(logged_in_user))
  end
end
