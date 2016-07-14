require('capybara/rspec')
require('./app')
require('launchy')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new train', {:type => :feature}) do
  it('allows a user to add a new train') do
    visit('/')
    fill_in('train_name', :with => "Meaghans Train")
    click_button('Add Train')
    expect(page).to have_content('Success!')
    click_link('Return Home')
    expect(page).to have_content("Meaghans Train")
  end
end

describe('deleting a train', {:type => :feature}) do
  it "allows a user to delete a train from the list" do
    train = Train.new({:name => "Meaghans Train"})
    train.save()
    train2 = Train.new({:name => "Calebs Train"})
    train2.save()
    visit("/")
    click_button("Delete Train")
    click_link("Return Home")
    expect(page).to have_content(train2.name())
  end
end

describe('adding a new city', {:type => :feature}) do
  it('allows a user to add a new city') do
    visit('/')
    fill_in('city_name', :with => "Oslo")
    click_button('Add City')
    expect(page).to have_content('Success!')
    click_link('Return Home')
    expect(page).to have_content('Oslo')
  end
end

describe("adding a city to a train", {:type => :feature}) do
  it "allows an admin to add a stop to a train route" do
    train = Train.new({:name => "Meaghans Train"})
    train.save()
    city = City.new({:name => "Oslo"})
    city.save()
    visit('/')
    click_link("Meaghans Train")
    save_and_open_page
  end
end
