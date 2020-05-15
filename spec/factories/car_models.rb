FactoryBot.define do
  factory :car_model do
    name { "Sedan" }
    year { "1999" }
    car_options { 'Opções extras' }
    motorization { "Cavalos" }
    fuel_type
    category
    manufacture
  end
end
