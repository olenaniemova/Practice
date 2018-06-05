class User < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :authored_reviews, dependent: :destroy, class_name: 'Review'
  has_many :reviews, as: :reviewable, dependent: :destroy
  belongs_to :city
  has_many :items_reviews, through: :items, source: :reviews

  def all_items_reviews
    items_reviews
  end
end
