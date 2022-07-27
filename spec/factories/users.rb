FactoryBot.define do
  factory :user do
    email { 'test@gmail.com' }
    password { 123_456_78 }
  end

  factory :random_user, class: User do
    email { Faker::Internet.email }
    password { 123_456_78 }
  end
end
