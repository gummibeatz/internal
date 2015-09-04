require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before(:each) do
    OmniAuth.config.mock_auth[:github] = nil
  end

  describe "as a developer" do
    it "should create an account from github" do
      create(:developer)
      request.env["omniauth.auth"] = valid_github_user_auth_hash
      get user_omniauth_authorize_path(:github)
    end
  end
end
