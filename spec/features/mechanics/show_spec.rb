require 'rails_helper'

RSpec.describe 'As a user', type: :feature do
  describe 'when I visit a mechanic show page' do
    it "I see their name, experience, all the rides they are working on, and a form to submit a ride to their workload" do
      mechanic = Mechanic.create!(name: "Rudolf Green", years_of_experience: 25)

      amusement_park = AmusementPark.create!(name: "Cedar Point", admission_price: 75)

      raptor = amusement_park.rides.create!(name: "The Raptor", thrill_rating: 7)
      dragster = amusement_park.rides.create!(name: "The Dragster", thrill_rating: 10)
      mf = amusement_park.rides.create!(name: "The Millenium Force", thrill_rating: 9)

      RideMechanic.create!(ride_id: raptor.id, mechanic_id: mechanic.id)
      RideMechanic.create!(ride_id: dragster.id, mechanic_id: mechanic.id)

      visit "/mechanics/#{mechanic.id}"

      expect(page).to have_content(mechanic.name)
      expect(page).to have_content("Years of Experience: #{mechanic.years_of_experience}")

      within ".rides-working-on" do
        expect(page).to have_content("Current rides they're working on:")
        expect(page).to have_content(raptor.name)
        expect(page).to have_content(dragster.name)
        expect(page).to_not have_content(mf.name)
      end

      within ".add-ride" do
        expect(page).to have_content("Add a ride to workload:")
        expect(find_field(:ride_search).value).to eq(nil)
        expect(page).to have_button("Submit")
      end

    end

    it "I can add a ride to the mechanic's workload" do
      mechanic = Mechanic.create!(name: "Rudolf Green", years_of_experience: 25)

      amusement_park = AmusementPark.create!(name: "Cedar Point", admission_price: 75)

      raptor = amusement_park.rides.create!(name: "The Raptor", thrill_rating: 7)
      dragster = amusement_park.rides.create!(name: "The Dragster", thrill_rating: 10)
      mf = amusement_park.rides.create!(name: "The Millenium Force", thrill_rating: 9)

      RideMechanic.create!(ride_id: raptor.id, mechanic_id: mechanic.id)
      RideMechanic.create!(ride_id: dragster.id, mechanic_id: mechanic.id)

      visit "/mechanics/#{mechanic.id}"

      within ".add-ride" do
        fill_in :ride_search, with: mf.id
        click_button "Submit"
      end

      expect(current_path).to eq("/mechanics/#{mechanic.id}")

      within ".rides-working-on" do
        expect(page).to have_content(raptor.name)
        expect(page).to have_content(dragster.name)
        expect(page).to have_content(mf.name)
      end
    end

    it "I cannot add a ride to mechanic's workload that doesn't exist in db" do
      mechanic = Mechanic.create!(name: "Rudolf Green", years_of_experience: 25)

      amusement_park = AmusementPark.create!(name: "Cedar Point", admission_price: 75)

      raptor = amusement_park.rides.create!(name: "The Raptor", thrill_rating: 7)
      dragster = amusement_park.rides.create!(name: "The Dragster", thrill_rating: 10)
      mf = amusement_park.rides.create!(name: "The Millenium Force", thrill_rating: 9)

      RideMechanic.create!(ride_id: raptor.id, mechanic_id: mechanic.id)
      RideMechanic.create!(ride_id: dragster.id, mechanic_id: mechanic.id)

      incorrect_id = Ride.last.id + 1

      visit "/mechanics/#{mechanic.id}"

      within ".add-ride" do
        fill_in :ride_search, with: incorrect_id
        click_button "Submit"
      end

      expect(current_path).to eq("/mechanics/#{mechanic.id}")
      expect(page).to have_content("Error: Invalid search query.")

    end

  end
end
