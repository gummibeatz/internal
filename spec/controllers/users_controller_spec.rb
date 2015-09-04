require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do

  before(:each) do
    OmniAuth.config.mock_auth[:github] = nil
  end

  describe "as a developer" do
    it "should create an account from github" do
      #create(:developer)
      # request.env["omniauth.auth"] = valid_github_user_auth_hash
      # get :github_oauth_2
    end
  end
end
