require 'rails_helper'

feature 'endorsing reviews' do
  scenario 'a user can endorse a review, which increments the endorsement count', js: true do
    user = build(:user)
    sign_up(user)
    add_restaurant
    add_review
    click_link 'Endorse'
    expect(page).to have_content("1 endorsement")
  end
end
