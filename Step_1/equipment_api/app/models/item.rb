class Item < ApplicationRecord
  has_many :bookings
  has_many :reviews, as: :reviewable
end
