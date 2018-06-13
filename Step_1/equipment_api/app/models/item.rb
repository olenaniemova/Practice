class Item < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  belongs_to :category
  has_and_belongs_to_many :filter_options

  scope :by_title, ->(word) { where('title ~* ?', word) }
  scope :by_category, ->(id) { joins(:category).where(categories: { id: id }) }
  scope :by_option, ->(id) { joins(:filter_options).where(filter_options: { id: id })  }

  scope :by_price_range, ->(p_start, p_end, days) {
    where(arel_table[:daily_price].between((p_start / days)..(p_end / days)))
  }

  scope :by_date_range, ->(d_start, d_end) {
    booking = Booking.arel_table
    b_start = booking[:start_date].between(d_start..d_end)
    b_end = booking[:end_date].between(d_start..d_end)
    query = booking.project(booking[:item_id]).where(b_start.or(b_end)).distinct.to_sql
    booking_items = Booking.find_by_sql(query)

    if booking_items.empty?
      query = Item.arel_table.project(Arel.sql('*'))
    else
      b_items = []
      booking_items.each { |b| b_items.push(b[:item_id]) }
      query = Item.arel_table[:id].not_eq_all(b_items)
    end
    Item.find_by_sql(query)
  }

end
