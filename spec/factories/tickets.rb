FactoryGirl.define do
  factory :ticket do
    association :user
    association :route
  end
end
