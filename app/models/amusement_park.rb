class AmusementPark < ApplicationRecord
  has_many :rides
  validates_presence_of :name, :admission_price

  def price_display
    "$" + self.admission_price.to_s + ".00"
  end

  def rides_average_thrill_rating
    self.rides.average(:thrill_rating)
  end

end
