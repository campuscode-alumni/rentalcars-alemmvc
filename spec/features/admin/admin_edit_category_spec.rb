require 'rails_helper'

feature 'Admin edits category' do
  scenario 'successfully' do
    user = create(:user, role: :admin)
    create(:category, name: 'PowerPlus', daily_rate: 12.9)
    login_as user, scope: :user

    visit root_path
    click_on 'Categorias'
    click_on 'Editar'
    find(:css, '.name').set('Conforto')
    find(:css, '.daily_rate').set(66.6)
    click_on 'Enviar'

    expect(page).to have_css('td', text: 'Conforto')
    expect(page).to have_css('td', text: 'R$ 66,6')
    expect(page).not_to have_css('td', text: 'PowerPlus')
    expect(page).not_to have_css('td', text: 'R$ 12.9')
  end

  scenario 'and must fill all fields' do
    user = create(:user, role: :admin)
    create(:category, name: 'PowerPlus', daily_rate: 12.9)
    login_as user, scope: :user

    visit root_path
    click_on 'Categorias'
    click_on 'Editar'
    find(:css, '.name').set('')
    find(:css, '.daily_rate').set('')
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Diária padrão não pode ficar em branco')
  end

  scenario 'and user can not register via url' do
    user = create(:user)
    category = create(:category, name: 'PowerPlus', daily_rate: 12.9)
    login_as user, scope: :user
    visit edit_category_path(category.id)

    expect(current_path).to eq root_path
  end
end
