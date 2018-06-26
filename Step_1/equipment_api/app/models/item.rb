class Item < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  belongs_to :category
  has_and_belongs_to_many :filter_options

  scope :by_title, ->(word) { where('title ~* ?', word) }
  scope :by_category, ->(id) { where(category_id: id) }
  scope :by_option, ->(id) { joins(:filter_options).where(filter_options: { id: id })  }

  scope :by_price_range, ->(start_pr, end_pr, days) {
    where(arel_table[:daily_price].between((start_pr.to_f / days.to_i)..(end_pr.to_f / days.to_i)))
  }

  scope :by_date_range, ->(start_d, end_d) {
    booking = Booking.arel_table
    b_start = booking[:start_date].between(start_d..end_d)
    b_end = booking[:end_date].between(start_d..end_d)
    booking_items = Booking.where(b_start.or(b_end)).pluck(:item_id).uniq
    Item.where(arel_table[:id].not_in(booking_items))
  }

  def add_filter_opions(fo_ids)
    self.filter_option_ids = fo_ids
  end
end
