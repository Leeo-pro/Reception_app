class Reservation < ApplicationRecord
  has_many :attendances
  
  def self.search(search)
    if search
      where(['name LIKE ?', "%#{search}%"])
    else
      all
    end
  end
  
end
