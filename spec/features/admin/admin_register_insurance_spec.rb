require 'rails_helper'

feature 'Admin register insurance' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary, name: 'Rent a Car')
    subsidiary.create_address!(attributes = {  street: 'A. Paulista', number: '100', 
      neighborhood: 'Cerqueira César', city: 'São Paulo', state: 'SP' })
    user = create(:user, role: :admin)
    create(:category, name: 'A')
    create(:category, name: 'B')

    login_as user, scope: :user
    visit root_path
    click_on 'Seguros'
    click_on 'Cadastrar Novo Seguro'
    fill_in 'Nome', with: 'Seguro Básico'
    fill_in 'Valor Diário', with: '59.90'
    select 'Categoria A', from: 'Categoria'
    click_on 'Enviar'

    expect(page).to have_content('Seguro Básico')
    expect(page).to have_content('Valor Diário: R$ 59,90')
  end
end
