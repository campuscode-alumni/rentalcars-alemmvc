require 'rails_helper'

feature 'Admin register category' do
  scenario 'sucessfully' do
    user = create(:user, role: :admin)
    login_as user, scope: :user

    visit root_path
    click_on 'Categorias'
    click_on 'Nova categoria'

    find(:css, '.name').set('Deluxe')
    find(:css, '.daily_rate').set(50.8)
    find(:css, '.car_insurance').set(51.4)
    find(:css, '.third_party_insurance').set(52.3)

    click_on 'Enviar'

    expect(page).to have_css('td', text: 'Deluxe')
    expect(page).to have_css('td', text: 'R$ 50,80')
    expect(page).to have_css('td', text: 'R$ 51,40')
    expect(page).to have_css('td', text: 'R$ 52,30')
  end

  scenario 'and must be admin' do
    user = create(:user)
    login_as user, scope: :user
    visit root_path

    expect(page).not_to have_content('Categorias')
  end

  scenario 'and user can not register via url' do
    user = create(:user)
    login_as user, scope: :user
    visit new_category_path

    expect(current_path).to eq root_path
  end

  scenario 'and rental prices are generated automatically' do
    subsidiary = create(:subsidiary, name: 'Herickson')
    other_subsidiary = create(:subsidiary, name: 'Claudionor')
    user = create(:user, role: :admin)
    login_as user, scope: :user

    visit root_path
    click_on 'Categorias'
    click_on 'Nova categoria'
    find(:css, '.name').set('Deluxe')
    find(:css, '.daily_rate').set(50.8)
    find(:css, '.car_insurance').set(51.4)
    find(:css, '.third_party_insurance').set(52.3)
    click_on 'Enviar'

    rental_prices = RentalPrice.all
    expect(rental_prices[0].category.name).to eq 'Deluxe'
    expect(rental_prices[0].subsidiary.name).to eq 'Herickson'
    expect(rental_prices[0].daily_rate).to eq 50.8
    expect(rental_prices[0].daily_car_insurance).to eq 51.4
    expect(rental_prices[0].daily_third_party_insurance).to eq 52.3
    expect(rental_prices[1].category.name).to eq 'Deluxe'
    expect(rental_prices[1].subsidiary.name).to eq 'Claudionor'
    expect(rental_prices[1].daily_rate).to eq 50.8
    expect(rental_prices[1].daily_car_insurance).to eq 51.4
    expect(rental_prices[1].daily_third_party_insurance).to eq 52.3
  end

  scenario 'and must fill all fields' do
    user = create(:user, role: :admin)
    login_as user, scope: :user

    visit root_path
    click_on 'Categorias'
    click_on 'Nova categoria'

    find(:css, '.name').set('')
    find(:css, '.daily_rate').set('')
    find(:css, '.car_insurance').set('')
    find(:css, '.third_party_insurance').set('')
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Diária padrão não pode ficar em branco')
    expect(page).to have_content('Seguro padrão do carro não pode ficar em branco')
    expect(page).to have_content('Seguro padrão contra terceiros')
  end
end
