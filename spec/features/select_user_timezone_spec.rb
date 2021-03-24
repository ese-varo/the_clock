require 'rails_helper'

RSpec.feature "Select user timezone", type: :feature do
  let!(:user) { create(:user, timezone: 'Alaska') }
  scenario 'visit clock page to choose one timezone to display' do
    sign_in user

    click_link 'My timezones'
    expect(page).to have_content 'Alaska'

    click_link 'Select my timezone'
    select "Chihuahua", from: 'timezone'
    click_button 'Save timezone'
    expect(page).to have_content 'User timezone save'
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

  scenario 'visit forecast page to see the forecast of the zone' do
    sign_in user
    click_link 'My timezones'
    click_button 'See forecast'
    today = Date.today
    expect(page).to have_content 'Alaska'
    expect(page).to have_content 'Timezone info:'
    expect(page).to have_content today.strftime("%A") 
    expect(page).to have_content today.change(day:today.day+1).strftime("%A") 
    expect(page).to have_content today.change(day:today.day+2).strftime("%A") 
    expect(page).to have_content today.change(day:today.day+3).strftime("%A") 
  end
end
