class Review < ApplicationRecord
  validates :rating, inclusion: (1..5)
  belongs_to :user
  belongs_to :restaurant
  has_many :endorsements
end
