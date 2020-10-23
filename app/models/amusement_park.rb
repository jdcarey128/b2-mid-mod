class AmusementPark < ApplicationRecord
  has_many :rides
  validates_presence_of :name, :admission_price

end
