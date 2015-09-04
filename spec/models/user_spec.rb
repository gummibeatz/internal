require 'rails_helper'

RSpec.describe User, type: :model do

  it { should belong_to(:developer) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

  it "should require a whitelisted email address" do
    expect(build(:random_user)).to_not be_valid
  end

  it "should allow whilelisted email addresses" do
    expect(build(:whitelist_user)).to be_valid
  end

  it "doesn't belong to a developer by default" do
    expect(build(:whitelist_user).developer.nil?).to be_truthy
  end

  describe "as developer" do
    it "doesn't validate whitelist email" do
      developer = create(:developer)
      user = build(:whitelist_user)
      developer.user = user
      expect(user).to be_valid
    end
  end

end
