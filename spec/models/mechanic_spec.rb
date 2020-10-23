require 'rails_helper'

RSpec.describe Mechanic, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :years_of_experience }
  end

  describe 'relationships' do
    it { should have_many :ride_mechanics }
    it { should have_many(:rides).through(:ride_mechanics) }
  end

  describe 'instance methods' do
    it 'alphabetized_rides' do
      mechanic = Mechanic.create!(name: "Rudolf Green", years_of_experience: 25)

      amusement_park = AmusementPark.create!(name: "Cedar Point", admission_price: 75)

      raptor = amusement_park.rides.create!(name: "The Raptor", thrill_rating: 7)
      dragster = amusement_park.rides.create!(name: "The Dragster", thrill_rating: 10)
      mf = amusement_park.rides.create!(name: "The Millenium Force", thrill_rating: 9)

      RideMechanic.create!(ride_id: raptor.id, mechanic_id: mechanic.id)
      RideMechanic.create!(ride_id: dragster.id, mechanic_id: mechanic.id)
      RideMechanic.create!(ride_id: mf.id, mechanic_id: mechanic.id)

      rides = [dragster, mf, raptor]

      expect(mechanic.alphabetized_rides).to eq(rides)
    end
  end

end
