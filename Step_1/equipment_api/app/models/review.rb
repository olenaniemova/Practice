class Review < ApplicationRecord
  belongs_to :users
  belongs_to :reviewable, polymorphic: true
end
