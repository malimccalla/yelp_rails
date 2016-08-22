require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants have been added' do
    scenario 'no restaurants have been added' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

end
