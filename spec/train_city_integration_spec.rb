require('capybara/rspec')
require('./app')
require('launchy')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new train', {:type => :feature}) do
  it('allows a user to click a train to see the tasks and details for it') do
    visit('/')
    fill_in('train_name', :with => "Meaghans Train")
    click_button('Add Train')
    expect(page).to have_content('Success!')
  end
end
