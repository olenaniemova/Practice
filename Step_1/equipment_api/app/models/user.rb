class User < ApplicationRecord
  has_many :items
  has_many :bookings
  has_many :reviews
  has_many :review, as: :reviewable
end
