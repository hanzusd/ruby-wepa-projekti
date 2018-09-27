require 'rails_helper'

RSpec.describe Beer, type: :model do

  describe "with all the right information" do
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }
    let(:test_beer) { Beer.create name: "testbeer", style: "teststyle", brewery: test_brewery }

    it "is saved to the database" do
      expect(Beer.count) == (1)
    end
  end
  
  describe "without all the right information" do
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }
    let(:test_beer) { Beer.create name: "testbeer", brewery: test_brewery }
    let(:test_beer2) { Beer.create style: "teststyle", brewery: test_brewery }

    it "is not saved to the database" do
      expect(Beer.count).to eq(0)
    end
  end
end
