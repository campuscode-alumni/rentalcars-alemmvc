require 'rails_helper'

feature 'Admin edit rental addons' do
  scenario 'successfully' do
    admin = create(:user, :admin)
    addon = create(:addon, name: 'Bebê conforto',
                           description: 'Uma cadeira bonita')
    build_addon = build(:addon)

    login_as admin
    visit root_path
    click_on 'Adicionais de locação'
    within "#addon-#{addon.id}" do
      click_on 'Editar'
    end
    fill_in 'Nome', with: build_addon.name
    fill_in 'Descrição', with: build_addon.description
    attach_file 'Foto', Rails.root.join('spec', 'fixtures', 'baby_chair.jfif')
    click_on 'Atualizar Adicional'

    expect(page).to have_content('Adicional atualizado com sucesso')
    expect(page).to have_content(build_addon.name)
    expect(page).to have_content(build_addon.description)
    expect(page).to have_css('img[src*="baby_chair.jfif"]')
  end

  scenario 'and must fill all fields' do
    admin = create(:user, :admin)
    addon = create(:addon, name: 'Bebê conforto',
                           description: 'Uma cadeira bonita')

    login_as admin
    visit root_path
    click_on 'Adicionais de locação'
    within "#addon-#{addon.id}" do
      click_on 'Editar'
    end
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Atualizar Adicional'

    expect(page).to have_content('Não foi possível gravar Adicional: 2 erros')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
  end
end
