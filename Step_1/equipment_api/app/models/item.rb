class Item < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  belongs_to :category
  has_and_belongs_to_many :filter_options

  scope :title, ->(word) { where('title ~* ?', word) }
  scope :category_id, ->(id) { joins(:category).where(categories: { id: id }) }
  scope :option, ->(id) { joins(:filter_options).where(filter_options: { id: id })  }
end
