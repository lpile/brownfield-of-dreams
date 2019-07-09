# frozen_string_literal: true

require 'rails_helper'

describe 'vister can create an account', :js do
  it 'creates sucessful account' do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'

    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on'Create Account'

    user = User.last

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Logged in as #{user.first_name}")
    expect(page).to have_content("This account has not yet been activated. Please check your email.")
    expect(page).to have_content("Status: Inactive")
    expect(page).to have_content(email)
    expect(page).to have_content(first_name)
    expect(page).to have_content(last_name)
    expect(page).to_not have_content('Sign In')

    visit "/#{user.confirm_token}/confirm_email"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Status: Active")
    expect(page).to have_content("Thank you! Your account is now activated.")
  end

  it 'creates sucessful account' do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'

    click_on 'Sign In'

    click_on 'Sign up now.'

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on'Create Account'

    user = User.last

    visit "/khjkjgkjgkjgkj/confirm_email"

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Sorry. User does not exist')
  end

  it 'displays error message if email already exists' do
    user = create(:user)

    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'

    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: user.email
    fill_in 'user[first_name]', with: user.first_name
    fill_in 'user[last_name]', with: user.last_name
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password

    click_on'Create Account'

    expect(current_path).to eq(new_user_path)
    expect(page).to have_content('Username already exists')
  end
end
