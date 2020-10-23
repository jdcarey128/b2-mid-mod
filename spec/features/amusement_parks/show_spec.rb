require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  describe "when I visit an amusement park show page" do
    it "I see the admission price, and all rides with the average thrill rating" do
      amusement_park = AmusementPark.create!(name: "Cedar Point", admission_price: 75)

      raptor = amusement_park.rides.create!(name: "The Raptor", thrill_rating: 7)
      dragster = amusement_park.rides.create!(name: "The Dragster", thrill_rating: 10)
      mf = amusement_park.rides.create!(name: "The Millenium Force", thrill_rating: 9)

      visit "/amusement_parks/#{amusement_park.id}"

      expect(page).to have_content(amusement_park.name)

      within ".admissions" do
        expect(page).to have_content("Admissions: #{amusement_park.price_display}")
      end

      within ".rides" do
        expect(page).to have_content(raptor.name)
        expect(page).to have_content(dragster.name)
        expect(page).to have_content(mf.name)
        expect(page).to have_content("Average Thrill Rating of Rides: #{amusement_park.rides_average_thrill_rating.round(1)}/10")
      end

    end
  end
end
