FactoryGirl.define do
  factory :idea do
    description "MyString"
    user nil
  end
  
  factory :user do
    username "julsfelic"
    first_name "Julian"
    last_name "Feliciano"
    password "password"
  end
end
