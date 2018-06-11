class Category < ApplicationRecord
  has_many :category_filters, dependent: :destroy
  has_many :filters, through: :category_filters, dependent: :destroy
  has_many :items, dependent: :destroy
end
