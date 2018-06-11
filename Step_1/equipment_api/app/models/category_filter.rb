class CategoryFilter < ApplicationRecord
  belongs_to :category
  belongs_to :filter
end
