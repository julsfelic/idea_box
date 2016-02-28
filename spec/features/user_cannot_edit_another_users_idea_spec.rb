require "rails_helper"

RSpec.feature "User cannot edit another users idea" do
  scenario "they are redirected to their dashboard" do
    logged_in_user = create(:user)
    login(logged_in_user)
    other_user = create(:user_with_idea)
    other_idea = other_user.ideas.last

    visit edit_user_idea_path(other_user, other_idea)

    expect(current_path).to_not eq(edit_user_idea_path(other_user, other_idea))
    expect(current_path).to eq(user_path(logged_in_user))
  end
end
