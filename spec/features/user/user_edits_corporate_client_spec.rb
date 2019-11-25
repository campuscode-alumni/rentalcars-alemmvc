require 'rails_helper'

feature 'User edits corporate client' do
  scenario 'successfully' do
    user = create(:user, role: :user)
    corporate_client = create(:corporate_client, trade_name: 'Joca',
                               cnpj: '2342342423', email: 'joca@email.com')
    corporate_client.create_address!(attributes = {  street: 'rua', number: '3', complement: '2',
                             neighborhood: 'vila', city: 'São Caetano',
                             state:'SP'} )

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes corporativos'
    click_on 'Joca'
    click_on 'Editar'
    fill_in 'Nome fantasia', with: 'Rebasers'
    fill_in 'CNPJ', with: '632.254.740-29'
    fill_in 'E-mail', with: 'rebase@email.com'
    fill_in 'Logradouro', with: 'R. Olimpia'
    fill_in 'Número', with: '431'
    fill_in 'Complemento', with: '87'
    fill_in 'Bairro', with: 'Jardim paulista'
    fill_in 'Cidade', with: 'Rio de Janeiro'
    fill_in 'Estado', with: 'RJ'
    click_on 'Enviar'

    expect(page).to have_content('Rebasers')
    expect(page).to have_content('632.254.740-29')
    expect(page).to have_content('rebase@email.com')
    expect(page).to have_content('R. Olimpia, nº 431')
    expect(page).to have_content('87')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('RJ')
  end
  
  scenario 'and must fill all fields' do
    user = create(:user, role: :user)
    corporate_client = create(:corporate_client, trade_name: 'Joca',
                               cnpj: '2342342423', email: 'joca@email.com')
    corporate_client.create_address!(attributes = {  street: 'rua', number: '3', complement: '2',
                             neighborhood: 'vila', city: 'São Caetano',
                             state:'SP'} )

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes corporativos'
    click_on 'Joca'
    click_on 'Editar'
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

  scenario 'must be logged in and access via url' do
    corporate_client = create(:corporate_client, trade_name: 'Joca',
                               cnpj: '2342342423', email: 'joca@email.com')
    corporate_client.create_address!(attributes = {  street: 'rua', number: '3', complement: '2',
                             neighborhood: 'vila', city: 'São Caetano',
                             state:'SP'} )

    visit edit_corporate_client_path(1)

    expect(current_path).to eq new_user_session_path
  end
end
