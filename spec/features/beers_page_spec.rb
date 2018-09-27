require 'rails_helper'

describe "Beer" do
    before :each do
        FactoryBot.create :brewery
    end

    it "with right information gets saved" do
        visit new_beer_path
        fill_in('beer_name', with: 'testibeer')
        fill_in('beer_style', with: 'testistyle')
        fill_in('beer_brewery_id', with: 1)

        expect{
            click_button('Create Beer')
        }.to change{Beer.count}.by(1)
    end
end
