require 'rails_helper'

describe 'Visitante abre a app', type: :system do
  it 'com sucesso' do
    visit root_path

    expect(page).to have_content 'Quadro de Vagas Rubi nos Trilhos'
  end

  it 'com sucesso e JavaScript', js: true do
    visit root_path

    expect(page).to have_css('p', text: 'Hello World! com Rails', wait: 2)
  end
end
