class FilterOption < ApplicationRecord
  belongs_to :filter
  has_many :item_options, dependent: :destroy
end
