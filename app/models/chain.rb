class Chain < ApplicationRecord
  belongs_to :bike
  has_one :chains_diag, dependent: :destroy
  has_many_attached :photos
end
