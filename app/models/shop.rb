class Shop < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many :appointments, dependent: :destroy
  has_one_attached :photo
end
