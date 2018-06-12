class Category < ApplicationRecord
  has_and_belongs_to_many :filters
  has_many :items, dependent: :destroy
end
