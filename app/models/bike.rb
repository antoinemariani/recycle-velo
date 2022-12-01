class Bike < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  validates :name, presence: true
end
