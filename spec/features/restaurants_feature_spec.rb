require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    let!(:kfc){Restaurant.create(name:'KFC')}
    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end


  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      user = build(:user)
      sign_up(user)
      add_restaurant
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    scenario "displays a default image if no image is uploaded" do
      user = build(:user)
      sign_up(user)
      add_restaurant
      expect(page).to have_css("img[src*='missing.png']")
      # expect(page).to have_xpath("//img[contains(@src,'missing.png')]")
    end

    scenario 'user must be signed in to create restaurant' do
      visit '/restaurants/new'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end

    context 'an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        user = build(:user)
        sign_up(user)
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end

  context 'viewing restaurants' do
    let!(:kfc){Restaurant.create(name:'KFC')}
    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do
    scenario 'let a user edit a restaurant' do
      user = build(:user)
      sign_up(user)
      add_restaurant
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do
    scenario 'removes a restaurant when a user clicks a delete link' do
      user = build(:user)
      sign_up(user)
      add_restaurant
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end
end
