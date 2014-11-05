require 'rails_helper'

feature "Sign up" do
  before :each do
    visit "/users/new"
  end

  it "has a user sign up page" do
    expect(page).to have_content "Sign Up"
  end

  it "takes a username and password" do
    expect(page).to have_content "Username"
    expect(page).to have_content "Password"
  end

  it "validates the presence of the user's username and password" do
    fill_in "Username", with: 'jack_bruce'
    click_button 'Sign Up'
    expect(page).to have_content 'Sign Up'
  end

  it "validates that the password is at least 6 characters long" do
    fill_in "Username", with: 'jack_bruce'
    fill_in "Password", with: 'short'
    click_button 'Sign Up'
    expect(page).to have_content 'Sign Up'
  end

  it "logs the user in and redirects them to posts index on success" do
    sign_up_as_jack_bruce
    # add user name to application.html.erb layout
    expect(page).to have_content 'jack_bruce'
    expect(current_path).to eq("/posts")
  end
end

feature "Sign out" do
  it "has a sign out button" do
    sign_up_as_jack_bruce
    expect(page).to have_button 'Sign Out'
  end

  it "logs a user out on click" do
    sign_up_as_jack_bruce

    click_button 'Sign Out'
    visit '/posts'

    # redirect to login page
    expect(current_path).to eq("/session/new")
    expect(page).to have_content 'Sign In'
  end
end

feature "Sign in" do
  it "has a sign in page" do
    visit "/session/new"
    expect(page).to have_content "Sign In"
  end

  it "takes a username and password" do
    visit "/session/new"
    expect(page).to have_content "Username"
    expect(page).to have_content "Password"
  end

  it "returns to sign in on non-existent user" do
    visit "/session/new"
    fill_in "Username", with: 'jack_bruce'
    fill_in "Password", with: 'hello'
    click_button "Sign In"

    # return to sign-in page
    expect(page).to have_content "Sign In"
  end

  it "returns to sign in on bad password" do
    sign_up_as_jack_bruce
    # add button to sign out in application.html.erb layout
    click_button 'Sign Out'

    visit "/session/new"
    fill_in "Username", with: 'jack_bruce'
    fill_in "Password", with: 'wrong_password'
    click_button "Sign In"

    # return to sign-in page
    expect(page).to have_content "Sign In"
  end

  it "takes a user to posts index on success" do
    sign_up_as_jack_bruce
    # add button to sign out in application.html.erb layout
    click_button 'Sign Out'

    # Sign in as newly created user
    visit "/session/new"
    fill_in "Username", with: 'jack_bruce'
    fill_in "Password", with: 'abcdef'
    click_button "Sign In"
    expect(page).to have_content "jack_bruce"
  end
end
