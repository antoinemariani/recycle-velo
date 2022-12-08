class Wheel < ApplicationRecord
  belongs_to :bike
  has_one :wheels_diag, dependent: :destroy
  has_many_attached :photos
end
