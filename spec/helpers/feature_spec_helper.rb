module FeatureSpecHelper
  def login(user)
    visit user_path(user)
    click_link "Login"
    fill_in "Username", with: user.username
    fill_in "Password", with: "password"
    click_button "Login"
  end
end
