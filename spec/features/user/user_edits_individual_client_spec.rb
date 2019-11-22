require 'rails_helper'

feature 'User edits individual client' do
  scenario 'successfully' do
    user = create(:user, role: :user)
    individual_client = create(:individual_client, name: 'Joca',
                               cpf: '2342342423', email: 'joca@email.com')
    individual_client.create_address!(attributes = {  street: 'rua', number: '3', complement: '2',
                             neighborhood: 'vila', city: 'São Caetano',
                             state:'SP'} )

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes individuais'
    click_on 'Joca'
    click_on 'Editar'
    fill_in 'Nome', with: 'Apolônio'
    fill_in 'CPF', with: '632.254.740-29'
    fill_in 'E-mail', with: 'apolonio@email.com'
    fill_in 'Logradouro', with: 'Vila do Chaves'
    fill_in 'Número', with: '71'
    fill_in 'Complemento', with: 'Dentro do barril'
    fill_in 'Bairro', with: 'México'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    click_on 'Enviar'

    expect(page).to have_content('Apolônio')
    expect(page).to have_content('632.254.740-29')
    expect(page).to have_content('apolonio@email.com')
    expect(page).to have_content('Vila do Chaves, nº 71')
    expect(page).to have_content('Dentro do barril')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('SP')
  end
  
  scenario 'and must fill all fields' do
    user = create(:user, role: :user)
    individual_client = create(:individual_client, name: 'Joca',
                               cpf: '2342342423', email: 'joca@email.com')
    individual_client.create_address!(attributes = {  street: 'rua', number: '3', complement: '2',
                             neighborhood: 'vila', city: 'São Caetano',
                             state:'SP'} )

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes individuais'
    click_on 'Joca'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'CPF', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Logradouro', with: ''
    fill_in 'Número', with: ''
    fill_in 'Complemento', with: ''
    fill_in 'Bairro', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco.')
    expect(page).to have_content('CPF não pode ficar em branco.')
    expect(page).to have_content('E-mail não pode ficar em branco.')
    expect(page).to have_content('Logradouro não pode ficar em branco.')
    expect(page).to have_content('Bairro não pode ficar em branco.')
    expect(page).to have_content('Cidade não pode ficar em branco.')
    expect(page).to have_content('Estado não pode ficar em branco.')
  end

  scenario 'must be logged in and access via url' do
    individual_client = create(:individual_client, name: 'Joca',
                               cpf: '2342342423', email: 'joca@email.com')
    individual_client.create_address!(attributes = {  street: 'rua', number: '3', complement: '2',
                             neighborhood: 'vila', city: 'São Caetano',
                             state:'SP'} )

    visit edit_individual_client_path(1)

    expect(current_path).to eq new_user_session_path
  end
end
