require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to(have_content("No restaurants yet"))
      expect(page).to(have_link("Add a restaurant"))
    end
  end

context 'user is signed in' do

  before do
    user_sign_up
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      fill_in 'Description', with: 'Terrible, never go here'
      click_button 'Create Restaurant'
      expect(page).to(have_content('KFC'))
      expect(current_path).to(eq('/restaurants'))
    end

    context 'an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to(have_css('h2', text: 'kf'))
        expect(page).to(have_content('error'))
      end
    end

  end

  context 'viewing restaurants' do

    before do
      user_create_restaurant
    end

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to(have_content('KFC'))
      expect(page).to(have_content('Terrible, never go here'))
    end
  end

  context 'editing restaurants' do
    before do
      user_create_restaurant
    end

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Awful, just terrible'
      click_button 'Update Restaurant'
      expect(page).to(have_content('Kentucky Fried Chicken'))
      expect(page).not_to(have_content('KFC'))
      expect(current_path).to(eq('/restaurants'))
    end
  end

  context 'deleting restaurants' do
    before do
      user_create_restaurant
    end

    scenario 'removes a restaurant when a user clicks delete' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to(have_content('KFC'))
      expect(page).to(have_content('Restaurant deleted successfully'))
    end
  end

end

  context 'when user is not signed in' do
   context 'creating restaurants' do
     scenario 'cannot create a restaurant when not signed in' do
       visit '/restaurants'
       click_link 'Add a restaurant'
       expect(current_path).to eq '/users/sign_in'
     end
   end

   context 'editing restaurants' do

    before do
      user_sign_up
      user_create_restaurant
      user_sign_out
    end

     scenario 'a user can not edit a restaurant' do
       visit '/restaurants'
       expect(page).not_to have_content 'Edit KFC'
     end
   end

   context 'deleting restaurants' do

     before do
       user_sign_up
       user_create_restaurant
       user_sign_out
     end

     scenario 'can not delete a restaurant' do
       visit '/restaurants'
       expect(page).not_to have_content 'Delete KFC'
     end
   end

  end

end
