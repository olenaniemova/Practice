class Item < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  belongs_to :category
  has_and_belongs_to_many :filter_options

  scope :by_title, ->(word) { where('title ~* ?', word) }
  scope :by_category, ->(id) { where(category_id: id) }
  scope :by_option, ->(id) { joins(:filter_options).where(filter_options: { id: id })  }

  scope :by_price_range, ->(p_start, p_end, days) {
    where(arel_table[:daily_price].between((p_start / days)..(p_end / days)))
  }

  scope :by_date_range, ->(d_start, d_end) {
    booking = Booking.arel_table
    b_start = booking[:start_date].between(d_start..d_end)
    b_end = booking[:end_date].between(d_start..d_end)
    booking_items = Booking.where(b_start.or(b_end)).distinct.pluck(:item_id)
    Item.where(arel_table[:id].not_in(booking_items))
  }
end
