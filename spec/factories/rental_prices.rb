FactoryBot.define do
  factory :rental_price do
    daily_rate { 1.5 }
    subsidiary { nil }
    category { nil }
  end
end
