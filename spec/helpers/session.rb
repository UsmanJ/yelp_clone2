module SessionHelpers
  def sign_up(user)
    visit '/users/sign_up'
    fill_in :Email, with: user.email
    fill_in :user_password, with: user.password
    fill_in :user_password_confirmation, with: user.password_confirmation
    click_button 'Sign up'
  end

  def sign_in(email:, password:)
    visit '/users/sign_in'
    fill_in :Email, with: user.email
    fill_in :user_password, with: user.password
    click_button 'Sign in'
  end

  def add_restaurant
    visit '/restaurants/new'
    fill_in :restaurant_name, with: "KFC"
    click_button 'Create Restaurant'
  end

  def add_review
    click_link 'Review KFC'
    fill_in :review_thoughts, with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
  end

  def delete_restaurant
    click_link "Delete KFC"
  end
end
