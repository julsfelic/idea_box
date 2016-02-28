require "rails_helper"

RSpec.feature "User cannot view another users ideas" do
  scenario "they are redirected to their dashboard" do
    logged_in_user = create(:user)
    login(logged_in_user)
    other_user = create(:user)

    visit user_ideas_path(other_user)

    expect(current_path).to_not eq(user_ideas_path(other_user))
    expect(current_path).to eq(user_path(logged_in_user))
  end
end
