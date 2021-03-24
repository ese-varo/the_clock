require 'rails_helper'

RSpec.feature "Select favorites timezones", type: :feature do 
  let!(:user) { create(:user, timezone: "Chihuahua") }
  scenario 'visit favorites timezones page to choose two favorites timezones' do
    sign_in user

    click_link 'My timezones'
    expect(page).to have_content 'Chihuahua'

    click_link 'See all available timezones'
    click_button(id: 'American_Samoa')
    expect(page).to have_content 'Timezone save as favorite'
    expect(page).to have_content 'American Samoa'

    click_link 'See all available timezones'
    click_button(id: 'Hawaii')
    expect(page).to have_content 'Timezone save as favorite'
    expect(page).to have_content 'Hawaii'
  end

  scenario "remove a timezone selected as favorite" do
    sign_in user

    click_link 'My timezones'
    expect(page).to have_content 'Chihuahua'

    click_link 'See all available timezones'
    click_button(id: 'American_Samoa')
    expect(page).to have_content 'Timezone save as favorite'
    expect(page).to have_content 'American Samoa'

    click_button 'Remove timezone'
    expect(page).to have_content 'Timezone deleted'
    expect(page).not_to have_content 'American Samoa'
  end
end
