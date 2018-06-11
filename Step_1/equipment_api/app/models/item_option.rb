class ItemOption < ApplicationRecord
  belongs_to :item
  belongs_to :filter_option
end
