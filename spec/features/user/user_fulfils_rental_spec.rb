require 'rails_helper'

feature 'User fulfils rental' do
  scenario 'and starts review by searching code' do
    subsidiary = create(:subsidiary, name: 'Almeida Motors')
    user = create(:user, subsidiary: subsidiary)
    manufacture = create(:manufacture)
    fuel_type = create(:fuel_type)
    category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                      third_party_insurance: 20)
    customer = create(:individual_client, name: 'Claudionor',
                    cpf: '318.421.176-43', email: 'cro@email.com')
    car_model = create(:car_model, name: 'Sedan', manufacture: manufacture,
                       fuel_type: fuel_type, category: category)
    car = create(:car, car_model: car_model, license_plate: 'TAT-1234')
    other_car = create(:car, car_model: car_model, license_plate: 'RER-1234')
    rental = create(:rental, category: category, subsidiary: subsidiary,
                    start_date: '3000-01-08', end_date: '3000-01-10',
                    client: customer, price_projection: 100, status: :scheduled)
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'
    fill_in 'Código da reserva', with: rental.reservation_code
    click_on 'Buscar'

    expect(page).to have_content(rental.reservation_code)
    expect(page).to have_content('Data de início: 08 de janeiro de 3000')
    expect(page).to have_content('Data de término: 10 de janeiro de 3000')
    expect(page).to have_content('Categoria: A')
    expect(page).to have_content('Locação de: Claudionor')
    expect(page).to have_content('CPF/CNPJ: 318.421.176-43')
    expect(page).to have_content('E-mail: cro@email.com')
    expect(page).to have_content(car.license_plate)
    expect(page).to have_content(other_car.license_plate)
    expect(rental.reload).to be_in_review
    expect(page).to have_button('Iniciar locação')
  end

  scenario 'susccesfully without addons' do
    subsidiary = create(:subsidiary, name: 'Almeida Motors')
    user = create(:user, subsidiary: subsidiary)
    manufacture = create(:manufacture)
    fuel_type = create(:fuel_type)
    category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                      third_party_insurance: 20)
    customer = create(:individual_client, name: 'Claudionor',
                    cpf: '318.421.176-43', email: 'cro@email.com')
    car_model = create(:car_model, name: 'Sedan', manufacture: manufacture,
                       fuel_type: fuel_type, category: category)
    create(:car, car_model: car_model, license_plate: 'MVM-838')
    create(:car, car_model: car_model, license_plate: 'TLA-090')
    rental = create(:rental, category: category, subsidiary: subsidiary,
                    start_date: '3000-01-08', end_date: '3000-01-10',
                    client: customer, price_projection: 100, status: :scheduled)
    addon_confort = create(:addon, name: 'Bebê conforto', daily_rate: 10.0)
    create(:addon_item, addon: addon_confort, registration_number: '123456',
           status: :available)
    create(:addon_item, addon: addon_confort, registration_number: '123456',
           status: :unavailable)
    addon_gps = create(:addon, name: 'GPS', daily_rate: 20.0)
    create(:addon_item, addon: addon_gps, registration_number: '123456',
           status: :unavailable)
    create(:addon_item, addon: addon_gps, registration_number: '789010',
           status: :available)
    create(:addon, name: 'Porta celular')
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'
    fill_in 'Código da reserva', with: rental.reservation_code
    click_on 'Buscar'
    choose 'TLA-090'
    click_on 'Iniciar locação'

    expect(page).to have_content('Confirmar dados da locação')
    expect(page).to have_content('Categoria: A')
    expect(page).to have_content('TLA-090')
    expect(page).to have_content('Valor estimado: R$ 100,00')
  end

  scenario 'successfully with addons' do
    subsidiary = create(:subsidiary, name: 'Almeida Motors')
    user = create(:user, subsidiary: subsidiary)
    manufacture = create(:manufacture)
    fuel_type = create(:fuel_type)
    category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                      third_party_insurance: 20)
    customer = create(:individual_client, name: 'Claudionor',
                    cpf: '318.421.176-43', email: 'cro@email.com')
    car_model = create(:car_model, name: 'Sedan', manufacture: manufacture,
                       fuel_type: fuel_type, category: category)
    create(:car, car_model: car_model, license_plate: 'MVM-838')
    create(:car, car_model: car_model, license_plate: 'TLA-090')
    rental = create(:rental, category: category, subsidiary: subsidiary,
                    start_date: '3000-01-08', end_date: '3000-01-10',
                    client: customer, price_projection: 100, status: :scheduled)
    addon_confort = create(:addon, name: 'Bebê conforto', daily_rate: 10.0)
    create(:addon_item, addon: addon_confort, registration_number: '123456',
           status: :available)
    create(:addon_item, addon: addon_confort, registration_number: '123456',
           status: :unavailable)
    addon_gps = create(:addon, name: 'GPS', daily_rate: 20.0)
    create(:addon_item, addon: addon_gps, registration_number: '123456',
           status: :unavailable)
    create(:addon_item, addon: addon_gps, registration_number: '789010',
           status: :available)
    create(:addon, name: 'Porta celular')
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'
    fill_in 'Código da reserva', with: rental.reservation_code
    click_on 'Buscar'
    find(:css, '#TLA-090').click
    find(:css, '#1').click
    find(:css, '#2').click
    click_on 'Iniciar locação'

    expect(page).to have_content('Confirmar dados da locação')
    expect(page).to have_content('Categoria: A')
    expect(page).to have_content('TLA-090')
    expect(page).to have_content('Bebê conforto: n 123456')
    expect(page).to have_content('GPS: n 789010')
    expect(page).to have_content('Valor estimado: R$ 160,00')
  end

  scenario 'and a car must be selected' do
    subsidiary = create(:subsidiary, name: 'Almeida Motors')
    user = create(:user, subsidiary: subsidiary)
    manufacture = create(:manufacture)
    fuel_type = create(:fuel_type)
    category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                      third_party_insurance: 20)
    customer = create(:individual_client, name: 'Claudionor',
                    cpf: '318.421.176-43', email: 'cro@email.com')
    car_model = create(:car_model, name: 'Sedan', manufacture: manufacture,
                       fuel_type: fuel_type, category: category)
    create(:car, car_model: car_model, license_plate: 'MVM-838')
    create(:car, car_model: car_model, license_plate: 'TLA-090')
    rental = create(:rental, category: category, subsidiary: subsidiary,
                    start_date: '3000-01-08', end_date: '3000-01-10',
                    client: customer, price_projection: 100, status: :scheduled)
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'
    fill_in 'Código da reserva', with: rental.reservation_code
    click_on 'Buscar'
    click_on 'Iniciar locação'

    expect(page).to have_content('Carro deve ser selecionado')
  end

  scenario 'and confirms rental' do
    subsidiary = create(:subsidiary, name: 'Almeida Motors')
    user = create(:user, subsidiary: subsidiary)
    manufacture = create(:manufacture)
    fuel_type = create(:fuel_type)
    category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                      third_party_insurance: 20)
    customer = create(:individual_client, name: 'Claudionor',
                    cpf: '318.421.176-43', email: 'cro@email.com')
    car_model = create(:car_model, name: 'Sedan', manufacture: manufacture,
                       fuel_type: fuel_type, category: category)
    create(:car, car_model: car_model, license_plate: 'MVM-838')
    create(:car, car_model: car_model, license_plate: 'TLA-090')
    rental = create(:rental, category: category, subsidiary: subsidiary,
                    start_date: '3000-01-08', end_date: '3000-01-10',
                    client: customer, price_projection: 100, status: :scheduled)
    addon_confort = create(:addon, name: 'Bebê conforto', daily_rate: 10.0)
    create(:addon_item, addon: addon_confort, registration_number: '123456',
           status: :available)
    create(:addon_item, addon: addon_confort, registration_number: '123456',
           status: :unavailable)
    addon_gps = create(:addon, name: 'GPS', daily_rate: 20.0)
    create(:addon_item, addon: addon_gps, registration_number: '123456',
           status: :unavailable)
    create(:addon_item, addon: addon_gps, registration_number: '789010',
           status: :available)
    create(:addon, name: 'Porta celular')
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'
    fill_in 'Código da reserva', with: rental.reservation_code
    click_on 'Buscar'
    find(:css, '#TLA-090').click
    find(:css, '#1').click
    find(:css, '#2').click
    click_on 'Iniciar locação'
    click_on 'Confirmar'

    expect(current_path).to eq rental_path(rental)
    expect(page).to have_content('em andamento')
  end

  scenario 'and user and rental must belong to same subsidiary' do
    subsidiary = create(:subsidiary, name: 'Almeidinha Motors')
    other_subsidiary = create(:subsidiary, name: 'MoratoMotors' )
    user = create(:user, subsidiary: subsidiary)
    manufacture = create(:manufacture)
    fuel_type = create(:fuel_type)
    category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                      third_party_insurance: 20)
    customer = create(:individual_client, name: 'Claudionor',
                    cpf: '318.421.176-43', email: 'cro@email.com')
    car_model = create(:car_model, name: 'Sedan', manufacture: manufacture,
                       fuel_type: fuel_type, category: category)
    create(:car, car_model: car_model, license_plate: 'MVM-838')
    create(:car, car_model: car_model, license_plate: 'TLA-090')
    rental = create(:rental, category: category, subsidiary: other_subsidiary,
                    start_date: '3000-01-08', end_date: '3000-01-10',
                    client: customer, price_projection: 100, status: :scheduled)
    addon_confort = create(:addon, name: 'Bebê conforto', daily_rate: 10.0)
    create(:addon_item, addon: addon_confort, registration_number: '123456',
           status: :available)
    create(:addon_item, addon: addon_confort, registration_number: '123456',
           status: :unavailable)
    addon_gps = create(:addon, name: 'GPS', daily_rate: 20.0)
    create(:addon_item, addon: addon_gps, registration_number: '123456',
           status: :unavailable)
    create(:addon_item, addon: addon_gps, registration_number: '789010',
           status: :available)
    create(:addon, name: 'Porta celular')
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'
    fill_in 'Código da reserva', with: rental.reservation_code
    click_on 'Buscar'

    expect(page).not_to have_button('Iniciar locação')
  end
end
