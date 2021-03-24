require 'rails_helper'

RSpec.feature "Alarms", type: :feature do 
  let!(:user) { create(:user) }
  let(:alarm) { attributes_for(:alarm) }

  scenario "create a new alarm" do
    sign_in user

    click_link 'My alarms'
    expect(page).to have_content "Alarms"
    click_link 'New Alarm'
    fill_in 'Label', with: alarm[:label]
    fill_in 'Time', with: alarm[:time]
    alarm[:days][1..4].each do |day|
      check("alarm_days_#{day.downcase}")
    end
    click_button 'Create Alarm'

    expect(page).to have_content 'New alarm created successfully'
    expect(page).to have_content "Label: #{alarm[:label]}"
  end

  scenario "create a new alarm with invalid label" do
    sign_in user

    click_link 'My alarms'
    click_link 'New Alarm'
    fill_in 'Label', with: nil
    fill_in 'Time', with: alarm[:time]
    alarm[:days][1..4].each do |day|
      check("alarm_days_#{day.downcase}")
    end
    click_button 'Create Alarm'
    expect(page).to have_content "Label can't be blank"
  end
  
  scenario "create a new alarm with invalid time" do
    sign_in user

    click_link 'My alarms'
    click_link 'New Alarm'
    fill_in 'Label', with: alarm[:label]
    alarm[:days][1..4].each do |day|
      check("alarm_days_#{day.downcase}")
    end
    click_button 'Create Alarm'
    expect(page).to have_content "Time can't be blank"
  end
  
  scenario "create a new alarm with invalid days" do
    sign_in user

    click_link 'My alarms'
    click_link 'New Alarm'
    fill_in 'Label', with: alarm[:label]
    fill_in 'Time', with: alarm[:time]
    click_button 'Create Alarm'
    expect(page).to have_content "Days can't be blank"
  end


  scenario "update a created alarm" do
    sign_in user
    new_alarm = create(:alarm, user: user)
    click_link 'My alarms'
    expect(page).to have_content "Label: #{new_alarm.label}"
    click_button 'Update alarm'
    fill_in 'Label', with: alarm[:label]
    fill_in 'Time', with: alarm[:time]
    new_alarm.days.each do |day| 
      uncheck("alarm_days_#{day.downcase}")
    end
    alarm[:days][0..2].each do |day|
      check("alarm_days_#{day.downcase}")
    end
    click_button 'Update Alarm'

    hours, minutes = alarm[:time].split(':')
    formatted_time = DateTime.new.change(hour: hours.to_i, min: minutes.to_i, offset: '-0700')
    expect(page).to have_content 'Alarm updated successfully'
    expect(page).to have_content "Label: #{alarm[:label]}"
    expect(page).to have_content "Time: #{formatted_time.strftime('%H:%M%p')}"
    expect(page).to have_content "Days: #{alarm[:days][0..2].join(', ')}"
  end

  scenario "delete a created alarm" do
    sign_in user
    new_alarm = create(:alarm, user: user)
    click_link 'My alarms'
    expect(page).to have_content "Label: #{new_alarm.label}"
    click_button 'Remove alarm'

    expect(page).to have_content 'Alarm deleted successfully'
    expect(page).not_to have_content "Label: #{new_alarm.label}"
  end
end
