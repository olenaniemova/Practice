class User < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :comments, dependent: :destroy, class_name: "Review"
  has_many :reviews, as: :reviewable, dependent: :destroy
end
