class User < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_many :review, as: :reviewable
end
