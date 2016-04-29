require 'rails_helper'
require 'spec_helper'

feature 'User signs in with Twitter' do
  scenario 'they see the log-in link on the page' do
    visit root_path

    page.has_content?("Sign In With Twitter")
  end
end
