# Feature: RSS feed
#   As a third party
#   I want to fetch a feed by domain
feature 'RSS feed' do

  # Scenario: Third party can fetch an RSS feed
  #   Given I have a valid domain
  #   When I fetch the feed
  #   Then I see a feed of upcoming posts
  scenario "user can fetch an rss feed" do
    visit '/example.com/twitter.xml'
    # stories
    expect(page).to have_content("example.com")
  end

  # Scenario: User cannot sign in with invalid account
  #   Given I have no account
  #   And I am not signed in
  #   When I sign in
  #   Then I see an authentication error message
  # scenario 'user cannot sign in with invalid account' do
  #   OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
  #   visit root_path
  #   expect(page).to have_content("Sign in")
  #   click_link "Sign in"
  #   expect(page).to have_content('Authentication error')
  # end

end

