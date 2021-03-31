require 'rails_helper'

RSpec.feature "Select user timezone", type: :feature do
  let!(:user) { create(:user, timezone: 'Alaska') }

  scenario 'visit clock page to choose one timezone to display', js: true do
    sign_in user

    click_link 'My timezones'
    expect(page).to have_content 'Alaska'

    click_link 'Select my timezone'
    expect(page).to have_content 'Select your timezone:', wait: 5
    select "Chihuahua", from: 'timezone'
    click_button 'Save timezone'
    expect(page).to have_content 'User timezone save', wait: 5
    expect(page).to have_content 'Chihuahua'
  end

  scenario 'visit clock page to display the current weather' do
    sign_in user

    click_link 'My timezones'
    expect(page).to have_content 'Alaska'
    expect(page).to have_content 'Weather'
    expect(page).to have_content 'Temperature'
  end
  
  scenario 'visit clock page with a timezone witout weather' do
    user_without_timezone = create(:user)
    sign_in user_without_timezone

    click_link 'My timezones'
    expect(page).to have_content 'Central Time'
    expect(page).to have_content 'The weather is unavailable'
  end

  scenario 'visit forecast page to see the forecast of the zone for tomorrow' do
    sign_in user
    click_link 'My timezones'
    click_button 'See forecast'
    expect(page).to have_content 'Alaska'
    expect(page).to have_content 'Timezone info:'
    expect(page).to have_content (Date.today + 1.days).strftime("%A") 
  end
end
