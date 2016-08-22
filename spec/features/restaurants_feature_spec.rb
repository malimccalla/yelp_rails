require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants have been added' do
    scenario 'no restaurants have been added' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'nandos')
    end
    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('nandos')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context ' creating restaurants' do
    scenario ' prompt user to fill out a form and then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'nandos'
      click_button 'Create Restaurant'
      expect(page).to have_content 'nandos'
      expect(current_path).to eq '/restaurants'
    end
  end

end
