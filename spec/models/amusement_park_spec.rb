require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :admission_price }
  end

  describe 'relationships' do
    it { should have_many :rides }
  end

  describe 'instance_methods' do
    it 'price_display' do
      amusement_park = AmusementPark.create!(name: "Cedar Point", admission_price: 100)

      expect(amusement_park.price_display).to eq("$100.00")
    end

    it 'rides_average_thrill_rating' do
      amusement_park = AmusementPark.create!(name: "Cedar Point", admission_price: 75)

      raptor = amusement_park.rides.create!(name: "The Raptor", thrill_rating: 8)
      dragster = amusement_park.rides.create!(name: "The Dragster", thrill_rating: 10)
      mf = amusement_park.rides.create!(name: "The Millenium Force", thrill_rating: 9)

      expect(amusement_park.rides_average_thrill_rating).to eq(9)
    end
  end
end
