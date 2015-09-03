require 'rails_helper'

RSpec.describe User, type: :model do
  
  it "should have valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }

    it "should not allow non developers not on c4q whitelist to be created" do
      expect(FactoryGirl.build(:user, :email=>"invalid@email.com")).to_not be_valid
    end
   
    it "should allow non developers on c4q whitelist to be created" do
      expect(FactoryGirl.build(:user, :email=>"testbot@email.com")).to be_valid
    end

    it "should allow developers on developer whitelist to create user" do
      expect {
        developer = FactoryGirl.create(:developer, github_username: "testbot")
        user = developer.create_user(email: developer.email,
                                     password: Devise.friendly_token[0,20])
      }.to change(User, :count)
    end

    it "should not allow developers not on developer whitelist to create a user" do
      expect {
        developer = FactoryGirl.create(:developer, github_username: "invalid_dev")
        user = developer.create_user(email:developer.email,
                                     password: Devise.friendly_token[0,20])
      }.to_not change(User, :count)
    end
    
  end

end
