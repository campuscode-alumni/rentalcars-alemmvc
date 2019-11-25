require 'rails_helper'

feature 'Admin register car model' do
  scenario 'successfully' do
    user = create(:user, role: :admin)
    create(:manufacture, name: 'Fiat')
    create(:fuel_type, name:'Gasolina')
    create(:category, name: 'A')

    login_as user, scope: :user
    visit root_path
    click_on 'Modelos'
    click_on 'Registrar novo modelo'
    fill_in 'Nome', with: 'Fiat Novo Uno 1.0'
    fill_in 'Ano', with: '2014/2015'
    select 'Fiat', from: 'Fabricante'
    fill_in 'Especificação do motor', with: '1.0'
    select 'Gasolina', from: 'Combustível'
    select 'A', from: 'Categoria'
    fill_in 'Características', with: '2 portas,5 pessoas'
    click_on 'Enviar'

    expect(page).to have_content('Nome')
    expect(page).to have_content('Fiat Novo Uno 1.0')
    expect(page).to have_content('Ano')
    expect(page).to have_content('2014/2015')
    expect(page).to have_content('Fabricante')
    expect(page).to have_content('Fiat')
    expect(page).to have_content('Especificação do motor')
    expect(page).to have_content('1.0')
    expect(page).to have_content('Combustível')
    expect(page).to have_content('Gasolina')
    expect(page).to have_content('Categoria')
    expect(page).to have_content('A')
    expect(page).to have_content('Características')
    expect(page).to have_content('2 portas')
    expect(page).to have_content('5 pessoas')
  end

  scenario 'and don\'t fill all fields' do
    user = create(:user, role: :admin)

    login_as user, scope: :user
    visit root_path
    click_on 'Modelos'
    click_on 'Registrar novo modelo'
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Ano não pode ficar em branco')
    expect(page).to have_content('Características não pode ficar em branco')
  end

  scenario 'and must be admin' do
    user = create(:user)
    create(:manufacture, name: 'Fiat')
    create(:category, name: 'A')

    login_as user, scope: :user
    visit root_path

    expect(page).not_to have_link('Criar modelo')
  end

  scenario 'must be admin and uses url' do
    user = create(:user)
    create(:manufacture, name: 'Fiat')
    create(:category, name: 'A')

    login_as user, scope: :user
    visit new_car_model_path

    expect(current_path).to eq root_path
  end
end
