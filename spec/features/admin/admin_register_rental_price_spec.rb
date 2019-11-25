require 'rails_helper'

feature 'Admin registers multiple rental prices' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary, name: 'Rent a Car')
    subsidiary.create_address!(attributes = {  street: 'A. Paulista', number: '100', 
      neighborhood: 'Cerqueira César', city: 'São Paulo', state: 'SP' })
    user = create(:user, role: :admin)
    category_a = create(:category, name: 'A')
    category_b = create(:category, name: 'B')
    create(:rental_price, category: category_a, subsidiary: subsidiary)
    create(:rental_price, category: category_b, subsidiary: subsidiary)

    login_as user, scope: :user
    visit root_path
    click_on 'Configurar preços de locações'
    click_on 'Editar valores'

    within('.rental_price1') do
      find(:css, '.daily_rate').set('50.0')
      find(:css, '.car_insurance').set('80.0')
      find(:css, '.third_party_insurance').set('75.0')
    end

    within('.rental_price2') do
      find(:css, '.daily_rate').set('54.70')
      find(:css, '.car_insurance').set('56.50')
      find(:css, '.third_party_insurance').set('43.10')
    end

    click_on 'Enviar'

    expect(page).to have_css('th', text: 'Categoria')
    expect(page).to have_css('th', text: 'Diária')
    expect(page).to have_css('th', text: 'Seguro do carro')
    expect(page).to have_css('th', text: 'Seguro contra terceiros')

    within('.rental_price1') do
      expect(page).to have_css('td', text: 'R$ 50,0')
      expect(page).to have_css('td', text: 'R$ 80,0')
      expect(page).to have_css('td', text: 'R$ 75,0')
    end

    within('.rental_price2') do
      expect(page).to have_css('td', text: 'R$ 54,7')
      expect(page).to have_css('td', text: 'R$ 56,5')
      expect(page).to have_css('td', text: 'R$ 43,1')
    end
  end

  scenario 'and must fill all fields' do
    subsidiary = create(:subsidiary, name: 'Rent a Car')
    subsidiary.create_address!(attributes = { street: 'A. Paulista', number: '100', 
      neighborhood: 'Cerqueira César', city: 'São Paulo', state: 'SP' })
    user = create(:user, role: :admin)
    category_a = create(:category, name: 'A')
    category_b = create(:category, name: 'B')
    create(:rental_price, category: category_a, subsidiary: subsidiary)
    create(:rental_price, category: category_b, subsidiary: subsidiary)

    login_as user, scope: :user
    visit root_path
    click_on 'Configurar preços de locações'
    click_on 'Editar valores'

    within('.rental_price1') do
      find(:css, '.daily_rate').set('')
      find(:css, '.car_insurance').set('')
      find(:css, '.third_party_insurance').set('')
    end

    within('.rental_price2') do
      find(:css, '.daily_rate').set('')
      find(:css, '.car_insurance').set('')
      find(:css, '.third_party_insurance').set('')
    end

    click_on 'Enviar'

    expect(page).to have_content('Diária não pode ficar em branco')
    expect(page).to have_content('Seguro do carro não pode ficar em branco')
    expect(page).to have_content('Seguro contra terceiros não pode ficar em '\
                                 'branco')
  end

  scenario 'and price table shows only last set prices' do
    subsidiary = create(:subsidiary, name: 'Rent a Car')
    subsidiary.create_address!(attributes = { street: 'A. Paulista', number: '100', 
      neighborhood: 'Cerqueira César', city: 'São Paulo', state: 'SP' })
    user = create(:user, role: :admin)
    category_a = create(:category, name: 'A')
    category_b = create(:category, name: 'B')
    create(:rental_price, category: category_a, subsidiary: subsidiary, daily_rate: 10,
           daily_car_insurance: 11, daily_third_party_insurance:12)
    create(:rental_price, category: category_b,subsidiary: subsidiary, daily_rate: 10,
           daily_car_insurance: 11, daily_third_party_insurance:12)

    login_as user, scope: :user
    visit root_path
    click_on 'Configurar preços de locações'
    click_on 'Editar valores'

    within('.rental_price1') do
      find(:css, '.daily_rate').set('50.0')
      find(:css, '.car_insurance').set('80.0')
      find(:css, '.third_party_insurance').set('75.0')
    end

    within('.rental_price2') do
      find(:css, '.daily_rate').set('54.70')
      find(:css, '.car_insurance').set('56.50')
      find(:css, '.third_party_insurance').set('43.10')
    end

    click_on 'Enviar'

    expect(page).to have_css('th', text: 'Categoria')
    expect(page).to have_css('th', text: 'Diária')
    expect(page).to have_css('th', text: 'Seguro do carro')
    expect(page).to have_css('th', text: 'Seguro contra terceiros')

    within('.rental_price1') do
      expect(page).to have_css('td', text: 'R$ 50,0')
      expect(page).to have_css('td', text: 'R$ 80,0')
      expect(page).to have_css('td', text: 'R$ 75,0')
    end

    within('.rental_price2') do
      expect(page).to have_css('td', text: 'R$ 54,7')
      expect(page).to have_css('td', text: 'R$ 56,5')
      expect(page).to have_css('td', text: 'R$ 43,1')
    end
  end

  scenario 'and must be admin' do
    subsidiary = create(:subsidiary, name: 'Rent a Car')
    subsidiary.create_address!(attributes = { street: 'A. Paulista', number: '100', 
      neighborhood: 'Cerqueira César', city: 'São Paulo', state: 'SP' })
    user = create(:user, role: :user)
    create(:category, name: 'A')
    create(:category, name: 'B')

    login_as user, scope: :user
    visit root_path
    click_on 'Preços de locações'

    expect(page).not_to have_content('Configurar preços')
  end

  scenario 'and user can not acess url' do
    subsidiary = create(:subsidiary, name: 'Rent a Car')
    user = create(:user)

    login_as user, scope: :user

    visit rental_price_subsidiary_path(subsidiary)

    expect(current_path).to eq root_path
  end
end
