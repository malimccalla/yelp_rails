require 'rails_helper'

feature 'reviewing' do
  before do
    user_sign_up
    user_create_restaurant
  end

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'The users email is displayed alongside their review' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(page).to have_content 'mali@mali.com'
  end



  scenario 'displays an average rating for all reviews' do
    leave_review('So so', '3')
    user_sign_out
    visit '/'
    click_link 'Sign up'
    fill_in "Email", with: 'test@test.com'
    fill_in "Password", with: '654321'
    fill_in "Password confirmation", with: '654321'
    click_button 'Sign up'
    visit '/'
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: ★★★★☆')
  end

end
