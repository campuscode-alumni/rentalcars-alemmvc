FactoryBot.define do
  factory :car do
    car_model { car_model }
    color { "Dourado" }
    license_plate { "CCC-000" }
    car_km { 100 }
    status { :available }
  end
end
