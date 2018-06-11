class Filter < ApplicationRecord
  has_many :category_filters, dependent: :destroy
  has_many :categories, through: :category_filters, dependent: :destroy
  has_many :filter_options, dependent: :destroy
end
