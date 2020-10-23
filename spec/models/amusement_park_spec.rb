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
  end
end
