require 'rails_helper'

feature 'User search rental' do
  scenario 'with correct token' do
    subsidiary = create(:subsidiary, name: 'Almeida Motors')
    user = create(:user, subsidiary: subsidiary)
    manufacture = create(:manufacture)
    fuel_type = create(:fuel_type)
    category = create(:category, name: 'A', daily_rate: 50)
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

    expect(current_path).to eq review_rental_path(rental.id)
  end

  scenario 'with invalid token' do
    subsidiary = create(:subsidiary, name: 'Almeida Motors')
    user = create(:user, subsidiary: subsidiary)
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'
    fill_in 'Código da reserva', with: 'ABC123'
    click_on 'Buscar'

    expect(current_path).to eq rentals_path
    expect(page).to have_content 'Não foi possível encontrar a locação'
  end
end
