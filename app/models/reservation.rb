class Reservation < ApplicationRecord
  has_many :attendances
end
