class Filter < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :filter_options, dependent: :destroy
end
