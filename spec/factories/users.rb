FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '12345678' }
    role { :user }

    trait :admin do
      role { :admin }
    end
   end
end
