require 'rails_helper'

feature 'User register corporate client' do
  scenario 'successfully' do
    user = create(:user, role: :user)
    login_as user, scope: :user
    
    visit root_path
    click_on 'Clientes corporativos'
    click_on 'Registrar cliente corporativo'
    fill_in 'Nome fantasia', with: 'Rebase'
    fill_in 'CNPJ', with: '62.932.555/0001-29'
    fill_in 'E-mail', with: 'contato@rebase.com'
    fill_in 'Logradouro', with: 'R. Santos'
    fill_in 'Número', with: '2222'
    fill_in 'Complemento', with: '777'
    fill_in 'Bairro', with: 'México'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    click_on 'Enviar'

    expect(page).to have_content('Rebase')
    expect(page).to have_content('62.932.555/0001-29')
    expect(page).to have_content('contato@rebase.com')
    expect(page).to have_content('R. Santos, nº 2222')
    expect(page).to have_content('777')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('SP')
  end

  scenario 'and must fill all fields' do
    user = create(:user, role: :user)
    login_as user, scope: :user

    visit root_path
    click_on 'Clientes corporativos'
    click_on 'Registrar cliente corporativo'
    fill_in 'Nome fantasia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Logradouro', with: ''
    fill_in 'Número', with: ''
    fill_in 'Complemento', with: ''
    fill_in 'Bairro', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome fantasia não pode ficar em branco.')
    expect(page).to have_content('CNPJ não pode ficar em branco.')
    expect(page).to have_content('E-mail não pode ficar em branco.')
    expect(page).to have_content('Logradouro não pode ficar em branco.')
    expect(page).to have_content('Bairro não pode ficar em branco.')
    expect(page).to have_content('Cidade não pode ficar em branco.')
    expect(page).to have_content('Estado não pode ficar em branco.')
  end

  scenario 'and must be logged in' do
    visit root_path

    expect(page).not_to have_content('Clientes corporativos')
  end

  scenario 'must be logged in and access via url' do
    visit new_individual_client_path

    expect(current_path).to eq new_user_session_path
  end
end
