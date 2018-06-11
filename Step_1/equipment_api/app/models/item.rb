class Item < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  belongs_to :category
  has_many :item_options, dependent: :destroy

  scope :title, ->(word) { where('title ~* ?', word) }
  scope :category_title, ->(word) { joins(:category).where(categories: { title: word }) }
  scope :option, ->(word) { joins(item_options: :filter_option).where(filter_options: { value: word })  }
end
