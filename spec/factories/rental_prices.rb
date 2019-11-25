FactoryBot.define do
  factory :rental_price do
    daily_rate { 1.5 }
    subsidiary { nil }
    category { nil }
    daily_car_insurance { 1.5 }
    daily_third_party_insurance { 1.5 }
  end
end
