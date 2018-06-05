class City < ApplicationRecord
  has_many :users, dependent: :destroy

  def all_items
    Item.joins(:user).where(users: { city_id: id })
  end
end
