FactoryGirl.define do
  factory :category do
    name "MyString"
    idea nil
  end
  factory :idea do
    sequence(:name) { |n| "Idea Name #{n}" }
    sequence(:description) { |n| "Idea Description #{n}" }
    user
  end

  factory :user do
    sequence(:username) { |n| "username #{n}" }
    sequence(:first_name) { |n| "Julian #{n}" }
    sequence(:last_name) { |n| "Feliciano #{n}" }
    password "password"

    factory(:user_with_idea) do
      transient do
        idea_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:idea, evaluator.idea_count, user: user)
      end
    end

    factory(:user_with_ideas) do
      transient do
        idea_count 3
      end

      after(:create) do |user, evaluator|
        create_list(:idea, evaluator.idea_count, user: user)
      end
    end
  end
end
