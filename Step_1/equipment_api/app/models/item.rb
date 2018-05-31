class Item < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
end
