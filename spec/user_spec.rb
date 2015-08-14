require 'spec_helper'

Rspec.describe User, "#sum" do
  context "with 2 integers" do
    it "sums the integers" do
      user = User.new
      expect(user.sum(10 + 5)).to eq 15
    end
  end
end

