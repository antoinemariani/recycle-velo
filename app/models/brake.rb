class Brake < ApplicationRecord
  belongs_to :bike
  has_one :brakes_diag, dependent: :destroy
  has_many_attached :photos
end
