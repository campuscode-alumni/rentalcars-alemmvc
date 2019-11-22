FactoryBot.define do
  factory :manufacture do
    name { Faker::Vehicle.manufacture }
  end
end
