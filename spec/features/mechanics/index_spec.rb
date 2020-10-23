require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'when I visit the mechanics index page' do
    it "I see a header 'All Mechanics' and a list of each mechanic and their years of experience" do
      mechanic_1 = Mechanic.create!(name: "Sam Mills", years_of_experience: 10)
      mechanic_2 = Mechanic.create!(name: "Kara Smith", years_of_experience: 11)
      mechanic_3 = Mechanic.create!(name: "Rudolf Green", years_of_experience: 25)

      visit "/mechanics"

      within ".mechanics" do
        expect(page).to have_content("All Mechanics")
        expect(page).to have_content(mechanic_1.name)
        expect(page).to have_content(mechanic_2.name)
        expect(page).to have_content(mechanic_3.name)
      end

      within "#mechanic-#{mechanic_1.id}" do
        expect(page).to have_content(mechanic_1.name)
        expect(page).to have_content("#{mechanic_1.years_of_experience} years of experience")
      end

      within "#mechanic-#{mechanic_2.id}" do
        expect(page).to have_content(mechanic_2.name)
        expect(page).to have_content("#{mechanic_2.years_of_experience} years of experience")
      end

      within "#mechanic-#{mechanic_3.id}" do
        expect(page).to have_content(mechanic_3.name)
        expect(page).to have_content("#{mechanic_3.years_of_experience} years of experience")
      end

    end
  end
end
