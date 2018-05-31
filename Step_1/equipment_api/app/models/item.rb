class Item < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :written_reviews, as: :reviewable, dependent: :destroy, class_name: "Review"
end
