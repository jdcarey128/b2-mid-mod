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
end
