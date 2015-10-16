require 'rails_helper'

feature 'endorsing reviews' do
  before do
    user = User.create(email: 'test@test.com', password: 'example1')
    restaurant = Restaurant.create(name: 'KFC', user_id: user.id)
    review = Review.create(restaurant_id: restaurant.id, user_id: user.id, rating: 1)
  end

  xscenario 'a user can endorse a review, which updates the review endorsement count' do
    visit '/restaurants'
    click_link 'Endorse Review'
    expect(page).to have_content('1 endorsement')
  end

  it 'a user can endorse a review, which increments the endorsement count', js: true do
    visit '/restaurants'
    click_link 'Endorse'
    expect(page).to have_content("1 endorsement")
  end

end
