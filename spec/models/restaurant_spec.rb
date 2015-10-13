require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }

  it 'removes reviews if restaurant is deleted' do
    restaurant = Restaurant.create(name: 'KFC')
    review = Review.create(thoughts: 'so so', rating: '2')
    restaurant.reviews << review
    expect { restaurant.destroy }.to change {Review.count}
  end

  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it "is not valid unless it has a unique name" do
    Restaurant.create(name: "Moe's Tavern")
    restaurant = Restaurant.new(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end
end