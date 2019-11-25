require 'rails_helper'

feature 'Admin edit subsidiary' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary, name: 'Rent a car')
    subsidiary.create_address!(attributes = {  street: 'A. Paulista', number: '100', 
      neighborhood: 'Cerqueira César', city: 'São Paulo', state: 'SP' })
    user = create(:user, role: :admin)

    login_as user, scope: :user
    visit root_path
    click_on 'Filiais'
    click_on 'Rent a car'
    click_on 'Editar'

    fill_in 'Nome', with: 'Car Rental'
    fill_in 'CNPJ', with: '80.325.500/0001-33'
    fill_in 'Logradouro', with: 'Rua da Consolação'
    fill_in 'Número', with: '50'
    fill_in 'Bairro', with: 'Centro'
    fill_in 'Cidade', with: 'S. Paulo'
    fill_in 'Estado', with: 'São Paulo'
    click_on 'Enviar'

    expect(page).to have_content('Car Rental')
    expect(page).to have_content('80.325.500/0001-33')
    expect(page).to have_content('Rua da Consolação')
    expect(page).to have_content('Centro')
    expect(page).to have_content('S. Paulo')
    expect(page).to have_content('São Paulo')
  end

  scenario 'and must fill all fields' do
    subsidiary = create(:subsidiary, name: 'Rent a car')
    subsidiary.create_address!(attributes = {  street: 'A. Paulista', number: '100', 
      neighborhood: 'Cerqueira César', city: 'São Paulo', state: 'SP' })

    user = create(:user, role: :admin)

    login_as user, scope: :user
    visit root_path
    click_on 'Filiais'
    click_on 'Rent a car'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Logradouro', with: ''
    fill_in 'Número', with: ''
    fill_in 'Bairro', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Logradouro não pode ficar em branco')
    expect(page).to have_content('Número não pode ficar em branco')
    expect(page).to have_content('Bairro não pode ficar em branco')
    expect(page).to have_content('Cidade não pode ficar em branco')
    expect(page).to have_content('Estado não pode ficar em branco')
  end

  scenario 'and must be admin' do
    user = create(:user)

    login_as user, scope: :user
    visit root_path
    
    expect(page).not_to have_link('Filiais')
  end

  scenario 'must be admin and uses url' do
    user = create(:user)

    login_as user, scope: :user
    visit new_subsidiary_path
  
    expect(current_path).to eq root_path
  end
end
