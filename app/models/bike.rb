class Bike < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  validates :name, presence: true
  has_many :chains, dependent: :destroy
  has_many :wheels, dependent: :destroy
  has_many :brakes, dependent: :destroy
  has_many :appointments
end
