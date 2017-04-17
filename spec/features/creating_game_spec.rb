require 'rails_helper'
require 'devise_helper'


RSpec.feature "Creating Games" do
  scenario "A user creates a new game" do

   visit "/log"
   fill_in "User Score", with: 21
   fill_in "Their Score", with: 9

   click_button "Save"

   expect(page).to have_content("Game was successfully created.")
  end


  scenario "A user creates an invalid game" do

   visit "/log"
   fill_in "User Score", with: 21
   fill_in "Their Score", with: 20

   click_button "Save"

   expect(page).to have_content("A game needs to be won by a two point margin")
  end



end