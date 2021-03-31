require 'rails_helper'

RSpec.feature "Stopwatches", type: :feature, js: true do
  let!(:user) { create(:user) }
  let!(:stopwatch) { attributes_for(:stopwatch) }

  scenario 'create a new stopwatch with 3 laps' do
    sign_in user

    click_link 'My stopwatches'
    expect(page).to have_content 'Records'

    fill_in 'Label', with: stopwatch[:label]
    click_button 'Start'
    sleep(5)
    click_button 'Save lap'
    3.times do 
      sleep(3)
      click_button 'Save lap'
    end
    click_button 'Pause'
    sleep(3)
    click_button 'Start'
    sleep(3)
    click_button 'Save lap'
    visit current_path
    expect(page).to have_content "Label: #{stopwatch[:label]}"
  end

  scenario 'delete a stopwatch created' do
    sign_in user

    click_link 'My stopwatches'

    fill_in 'Label', with: stopwatch[:label]
    click_button 'Start'
    sleep(5)
    click_button 'Save lap'
    sleep(3)
    click_button 'Save lap'
    visit current_path 
    expect(page).to have_content "Label: #{stopwatch[:label]}"

    click_button 'Remove'
    expect(page).to have_content "Stopwatch deleted successfully"
    expect(page).not_to have_content "Label: #{stopwatch[:label]}"
  end

  scenario 'show records for a stopwatch created' do
    sign_in user

    click_link 'My stopwatches'
    expect(page).to have_content 'Records'

    fill_in 'Label', with: stopwatch[:label]
    click_button 'Start'
    sleep(5)
    click_button 'Save lap'
    3.times do 
      sleep(3)
      click_button 'Save lap'
    end
    visit current_path
    click_button 'Show laps'
    lap = Stopwatch.find(1).laps.first
    expect(page).to have_content 'Stopwatch record'
    expect(page).to have_content "Name: #{stopwatch[:label]}"
    expect(page).to have_content "Lap Time: #{StopwatchDecorator.new(lap).display_lap_time} - Lap duration: #{StopwatchDecorator.new(lap).display_lap_difference}"
  end
end
