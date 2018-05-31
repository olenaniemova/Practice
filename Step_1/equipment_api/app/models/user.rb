class User < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :authored_reviews, dependent: :destroy, class_name: "Review"
  has_many :written_reviews, as: :reviewable, dependent: :destroy, class_name: "Review"
end
