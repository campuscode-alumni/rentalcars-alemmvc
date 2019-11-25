require 'rails_helper'

feature 'Admin edit car model' do
  scenario 'successfully' do
    manufacture = create(:manufacture, name: 'Fiat')
    fuel_type = create(:fuel_type, name: 'Gasolina')
    fuel_type2 = create(:fuel_type, name: 'Álcool')
    categ = create(:category, name: 'A')
    categ2 = create(:category, name: 'C')
    car_model = create(:car_model, name: 'Fiat Novo Uno', 
                       manufacture: manufacture, year: '2014/2015',
                       motorization: '1.0', fuel_type: fuel_type,
                       category: categ, car_options: '2 portas,5 pessoas')
    user = create(:user, role: :admin)

    login_as user, scope: :user
    visit root_path
    click_on 'Modelos'
    click_on 'Fiat Novo Uno'
    click_on 'Editar'

    fill_in 'Nome', with: 'Fiat 147'
    select 'Fiat', from: 'Fabricante'
    fill_in 'Ano', with: '1990'
    select 'Álcool', from: 'Combustível'
    fill_in 'Especificação do motor', with: '1.3'
    select 'C', from: 'Categoria'
    fill_in 'Características', with: '3 portas'
    click_on 'Enviar'

    expect(page).to have_content('Fiat 147')
    expect(page).to have_content('1990')
    expect(page).to have_content('1.3')
    expect(page).to have_content('Álcool')
    expect(page).to have_content('C')
    expect(page).to have_content('3 portas')
  end

  scenario 'and does not allow saving with invalid data' do
    manufacture = create(:manufacture, name: 'Fiat')
    fuel_type = create(:fuel_type, name: 'Gasolina')
    categ = create(:category, name: 'A')
    car_model = create(:car_model, name: 'Fiat Novo Uno', 
                       manufacture: manufacture, year: '2014/2015',
                       motorization: '1.0', fuel_type: fuel_type,
                       category: categ, car_options: '2 portas,5 pessoas')
    user = create(:user, role: :admin)

    login_as user, scope: :user

    visit edit_car_model_path(car_model)

    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end
end
