FactoryBot.define do
  factory :car_model do
    name { "Sedan" }
    year { "1999" }
    manufacture 
    motorization { "Cavalos" }
    fuel_type
    category
    car_options { 'Opções extras' }
  end
end
