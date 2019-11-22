FactoryBot.define do
  factory :addon do
    name { Faker::Lorem.word.capitalize }
    description { Faker::Lorem.paragraph }
    photo do
      fixture_file_upload(Rails.root.join('spec', 'fixtures', '150x150.png'), 
                          'image/png')
    end
  end
end
