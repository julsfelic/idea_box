FactoryGirl.define do
  factory :idea do
    name "MyName"
    description "MyString"
    user
  end

  factory :user do
    username "julsfelic"
    first_name "Julian"
    last_name "Feliciano"
    password "password"

    factory(:user_with_idea) do
      transient do
        idea_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:idea, evaluator.idea_count, user: user)
      end
    end
  end
end
