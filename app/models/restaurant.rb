class Restaurant < ActiveRecord::Base
  belongs_to :user
  has_many :reviews,
        -> { extending WithUserAssociationExtension },
        dependent: :destroy

  validates :name, length: {minimum: 3}, uniqueness: true

  def average_rating
    return 'N/A' if reviews.none?
    self.reviews.inject(0) {|memo, review| memo + review.rating} / self.reviews.length
  end
end
