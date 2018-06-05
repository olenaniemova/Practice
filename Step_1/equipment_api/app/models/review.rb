class Review < ApplicationRecord
  belongs_to :user
  belongs_to :reviewable, polymorphic: true
  validate :cannot_leave_review_for_an_item, :cannot_leave_review_for_a_user,
           on: :create

  def cannot_leave_review_for_a_user
    return unless reviewable_type == 'User'
    booking = Booking.joins(:item).where(items: { user_id: reviewable_id }, bookings: { user_id: user_id })
    renting = Booking.joins(:item).where(items: { user_id: user_id }, bookings: { user_id: reviewable_id })
    if booking.empty? && renting.empty?
      errors.add(:user_id, 'You cannot leave a review for a user you never dealt with')
    end
  end

  def cannot_leave_review_for_an_item
    return unless reviewable_type == 'Item'
    booking = Booking.where(bookings: { user_id: user_id, item_id: reviewable_id })
    errors.add(:user_id, 'You cannot leave a review for an item you never booked') if booking.empty?
  end

end
