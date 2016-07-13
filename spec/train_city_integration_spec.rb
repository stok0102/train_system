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
    click_button('Return Home')
  end
end

describe('viewing all the trains', {:type => :feature}) do
  it "allows a user to see all of the trains that have been created" do
    train = Train.new({:name => 'Meaghans Train'})
    train.save()
    visit('/')
    expect(page).to have_content(train.name)
  end
end
