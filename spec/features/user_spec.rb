require 'rails_helper'

RSpec.feature "Users", type: :feature do
  let(:user) { build(:user) } 
  scenario 'visit root page as a guess user' do
    visit root_path

    expect(page).to have_content('Central Time (US & Canada)')

    click_link 'See all available timezones'
    timezones = ActiveSupport::TimeZone.all
    expect(page).to have_content(timezones[rand(0...timezones.length)].name)
  end

  scenario 'sign up in the application' do
    visit root_path
    click_link 'Register'

    expect(page).to have_content 'Sign up'
    expect {
      fill_in 'Name', with: user.name
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: user.password
      click_button 'Sign up'
    }.to change(User, :count).by(1)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Edit my account'
    expect(page).to have_content 'Sign out'
  end

  scenario 'log in the application' do
    user = create(:user)
    sign_in user
    expect(page).to have_content 'Edit my account'
    expect(page).to have_content 'Sign out'
  end
end
