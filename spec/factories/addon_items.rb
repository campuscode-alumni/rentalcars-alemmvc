FactoryBot.define do
  factory :addon_item do
    addon { addon }
    registration_number { "NUMERODEREGISTRO" }
    status { :available }
  end
end
