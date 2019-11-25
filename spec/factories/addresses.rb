FactoryBot.define do
  factory :address do
    street { "Rua da Consolação" }
    number { "100" }
    complement { " conj. 66" }
    neighborhood { "Cerqueira César" }
    city { "São Paulo" }
    state { "SP" }
    subsidiary { nil }
  end
end
