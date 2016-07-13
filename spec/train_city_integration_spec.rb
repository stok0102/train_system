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
