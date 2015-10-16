class Restaurant < ActiveRecord::Base
  belongs_to :user
  has_many :reviews,
        -> { extending WithUserAssociationExtension },
        dependent: :destroy

  validates :name, length: {minimum: 3}, uniqueness: true

  def average_rating
    return 'N/A' if reviews.none?
    p reviews.inject(0) {|memo, review| memo + review.rating} / reviews.length
    p reviews.average(:rating)
    reviews.average(:rating)
  end
end
