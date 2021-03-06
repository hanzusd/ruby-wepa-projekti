require 'rails_helper'

describe "Beerlist page" do
    before :all do
        Capybara.register_driver :selenium do |app|
          capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
            chromeOptions: { args: ['headless', 'disable-gpu']  }
          )
      
          Capybara::Selenium::Driver.new app,
            browser: :chrome,
            desired_capabilities: capabilities      
        end
        WebMock.disable_net_connect!(allow_localhost: true) 
      end
  

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name:"Koff")
    @brewery2 = FactoryBot.create(:brewery, name:"Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name:"Ayinger")
    @beer1 = FactoryBot.create(:beer, name:"Nikolai", brewery: @brewery1, style:"Lager")
    @beer2 = FactoryBot.create(:beer, name:"Fastenbier", brewery:@brewery2, style:"Rauchbier")
    @beer3 = FactoryBot.create(:beer, name:"Lechte Weisse", brewery:@brewery3, style:"Weizen")
  end

  it "shows one known beer" , js:true do
    visit beerlist_path
    expect(page).to have_content "Nikolai"
  end

  it "puts beers in alphabetical order automatically" , js:true do
    visit beerlist_path
    expect(find('table').find('tr:nth-child(2)')).to have_content "Fastenbier"
    expect(find('table').find('tr:nth-child(3)')).to have_content "Lechte Weisse"
    expect(find('table').find('tr:nth-child(4)')).to have_content "Nikolai"
  end

  it "arranges beers by style" , js:true do
    visit beerlist_path
    click_link "style"
    expect(find('table').find('tr:nth-child(2)')).to have_content "Nikolai"
    expect(find('table').find('tr:nth-child(3)')).to have_content "Fastenbier"
    expect(find('table').find('tr:nth-child(4)')).to have_content "Lechte Weisse"
  end

  it "arranges beers by brewery" , js:true do
    visit beerlist_path
    click_link "brewery"
    expect(find('table').find('tr:nth-child(2)')).to have_content "Lechte Weisse"
    expect(find('table').find('tr:nth-child(3)')).to have_content "Nikolai"
    expect(find('table').find('tr:nth-child(4)')).to have_content "Fastenbier"
  end
end
