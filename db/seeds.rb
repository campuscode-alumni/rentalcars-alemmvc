subsidiary = Subsidiary.create(name: 'Almeidinha Motors',
                               cnpj: '57.669.960/0001-66')
User.create(email: 'user@email.com', password: '123456', subsidiary: subsidiary,
            role: :user)
User.create(email: 'admin@email.com', password: '123456', role: :admin)
category_a = Category.create(name: 'A', daily_rate: 50.0, car_insurance: 50.0,
           third_party_insurance: 50.0)
category_b = Category.create(name: 'B', daily_rate: 50.0, car_insurance: 50.0,
           third_party_insurance: 50.0)
category_c = Category.create(name: 'C', daily_rate: 50.0, car_insurance: 50.0,
           third_party_insurance: 50.0)
RentalPrice.create(category: category_a, subsidiary: subsidiary,
                   daily_rate: 32.0, daily_car_insurance: 33.0,
                   daily_third_party_insurance: 34.0)
RentalPrice.create(category: category_b, subsidiary: subsidiary,
                   daily_rate: 22.0, daily_car_insurance: 73.0,
                   daily_third_party_insurance: 34.0)
RentalPrice.create(category: category_c, subsidiary: subsidiary,
                   daily_rate: 36.0, daily_car_insurance: 23.0,
                   daily_third_party_insurance: 44.0)
Manufacture.create(name: 'Fiat')
Manufacture.create(name: 'Ford')
FuelType.create(name: 'Gasolina')
FuelType.create(name: 'Álcool')
