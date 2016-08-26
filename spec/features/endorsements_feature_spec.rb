require 'rails_helper'

feature 'endorsing reviews' do
  before do
    user_sign_up
    user_create_restaurant
    leave_review('so so', 3)
  end

  it 'a user can endorse a review, which increments the endorsement count', js: true do
    visit '/restaurants'
    click_link 'Endorse'
    expect(page).to have_content("1 endorsement")
  end
end
