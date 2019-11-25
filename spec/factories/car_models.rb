FactoryBot.define do
  factory :car_model do
    name { "Sedan" }
    year { "1999" }
    manufacture { manufacture }
    motorization { "Cavalos" }
    fuel_type { fuel_type }
    category { category }
    car_options { 'Opções extras' }
  end
end
