require 'rails_helper'

feature 'reviewing' do
  scenario 'allows users to leave a review using a form' do
    user = build(:user)
    sign_up(user)
    add_restaurant
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'removes reviews if restaurant is deleted' do
    user = build(:user)
    sign_up(user)
    add_restaurant
    add_review
    delete_restaurant
    expect(page).to_not have_content('so so')
  end

  def leave_review(thoughts, rating)
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end

  scenario 'displays an average rating for all reviews' do
    user = build(:user)
    user2 = build(:usertwo)
    sign_up(user)
    add_restaurant
    add_review
    click_link 'Sign out'
    sign_up(user2)
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: 4')
  end
end
