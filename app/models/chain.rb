class Chain < ApplicationRecord
  belongs_to :bike
  has_many_attached :photos
end
