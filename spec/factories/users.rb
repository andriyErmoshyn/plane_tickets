FactoryGirl.define do
  factory :user do
    email              { Faker::Internet.email }
    first_name       { Faker::Name.first_name }
    last_name       { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.cell_phone }
    role 0
    password                     "password"
    password_confirmation "password"

    factory(:admin) { role 1 }

    factory(:non_logged_in_user) { role nil }

  end
end
