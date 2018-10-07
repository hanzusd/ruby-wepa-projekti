require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if more than one is returned by the API, all are shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("helsinki").and_return( 
        [ Place.new( name: "Pullman Bar", id: 1 ), Place.new( name: "Belge", id: 2) ]
    )

    visit places_path
    fill_in('city', with: 'helsinki')
    click_button "Search"

    expect(page).to have_content "Pullman Bar"
    expect(page).to have_content "Belge"
  end

  it "if API doesn't return any, right error is shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("helsinki").and_return( 
        [ ]
    )
    
    visit places_path
    fill_in('city', with: 'helsinki')
    click_button "Search"

    expect(page).to have_content "No locations in helsinki"
  end


end
