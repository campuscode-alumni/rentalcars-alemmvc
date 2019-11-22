require 'rails_helper'

feature 'User register car' do
  scenario 'successfully' do
    user = create(:user, role: :user)
    fiat = create(:manufacture, name: 'Fiat')
    gasolina = create(:fuel_type, name: 'Gasolina')
    categ = create(:category, name: 'A')
    create(:car_model, name: 'Sport', manufacture: fiat, fuel_type: gasolina, category: categ )

    login_as user, scope: :user
    visit root_path

    click_on 'Registrar novo carro'
    select 'Sport', from: 'Modelo'
    fill_in 'Quilometragem', with: '200'
    fill_in 'Cor', with: 'Verde Musgo'
    fill_in 'Placa', with: 'HPL6666'
    click_on 'Criar carro'

    expect(page).to have_content('Modelo')
    expect(page).to have_content('Sport')
    expect(page).to have_content('Quilometragem')
    expect(page).to have_content('200')
    expect(page).to have_content('Cor')
    expect(page).to have_content('Verde Musgo')
    expect(page).to have_content('Placa')
    expect(page).to have_content('HPL6666')
  end

  scenario 'and must fill all fields' do
    user = create(:user, role: :user)

    login_as user, scope: :user
    visit root_path
    click_on 'Registrar novo carro'
    click_on 'Criar carro'

    expect(page).to have_content('Modelo é obrigatório')
    expect(page).to have_content('Quilometragem não pode ficar em branco')
    expect(page).to have_content('Cor não pode ficar em branco')
    expect(page).to have_content('Placa não pode ficar em branco')
  end

  scenario 'and must not be admin to see button' do
    user = create(:user, role: :admin)
    fiat = create(:manufacture, name: 'Fiat')
    gasolina = create(:fuel_type, name: 'Gasolina')
    categ = create(:category, name: 'A')
    create(:car_model, name: 'Sport', manufacture: fiat, fuel_type: gasolina, category: categ )

    login_as user, scope: :user
    visit root_path

    expect(page).not_to have_link('Registrar novo carro')
  end

  scenario 'and must be user' do
    visit root_path

    expect(page).not_to have_content('Registrar novo carro')
  end

  scenario 'and visitor can not regiser via url' do
    visit new_car_path

    expect(current_path).to eq new_user_session_path
  end
end
