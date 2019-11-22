require 'rails_helper'

feature 'Admin login to system' do
  scenario 'successfully' do
    user = create(:user, role: :admin)

    visit root_path
    fill_in 'E-mail', with: user.email
    fill_in 'Senha', with: user.password
    within('div.login_form') do
      click_on 'Entrar'
    end

    expect(page).to have_content(user.email)
    expect(page).to have_link('Sair')
  end

  scenario 'and log out' do
    user = create(:user, role: :admin)

    visit root_path
    fill_in 'E-mail', with: user.email
    fill_in 'Senha', with: user.password
    within('div.login_form') do
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(page).not_to have_content(user.email)
    expect(page).to have_link('Entrar')
  end
end
