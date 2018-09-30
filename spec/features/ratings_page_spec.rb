require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryBot.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end
  
  it "shows the right number of ratings" do
    FactoryBot.create(:rating, score: 4, user:user)
    FactoryBot.create(:rating, score: 6, user:user)
    visit ratings_path

    expect(page).to have_content 'Number of ratings: 2'
  end

  it "shows right ratings on the page" do
    FactoryBot.create(:rating, score: 4, beer:beer1, user:user)
    FactoryBot.create(:rating, score: 6, beer:beer2, user:user)
    visit ratings_path

    expect(page).to have_content 'iso 3 4 Pekka'
    expect(page).to have_content 'Karhu 6 Pekka'
  end

  it "when given shows up on the right users' page" do
    FactoryBot.create(:rating, score: 4, beer:beer1, user:user)
    FactoryBot.create(:rating, score: 6, beer:beer2, user:user)
    visit user_path(user)

    expect(page).to have_content 'Has made 2 ratings'
    expect(page).to have_content 'iso 3 4'
    expect(page).to have_content 'Karhu 6'
  end

  it "is deleted when user deletes it" do
    FactoryBot.create(:rating, score: 4, beer:beer1, user:user)
    FactoryBot.create(:rating, score: 6, beer:beer2, user:user)
    visit user_path(user)

    expect{
      find(:xpath, './/a[@href="/ratings/2"]').click()
    }.to change{Rating.count}.by(-1)

    expect(page).to have_content 'iso 3 4'
  end
end
