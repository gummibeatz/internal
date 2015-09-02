require 'rails_helper'

RSpec.describe User, type: :model do
  

  it "allows only white-list users to be created" do
    expect(User.create!(email: "testbot@email.com",
                        password: "12345678")
          ).to be_valid

    expect(User.create(email: "invalid@email.com",
                      password: "12345678")
          ).to_not be_valid
  end

  it "does not allow duplicates" do
    expect{
      User.create(email: "testbot@email.com",
                  password: "12345678")
    }.to change(User, :count).by(1)

    expect{
      User.create(email: "testbot@email.com",
                  password: "123135346")
    }.to_not change(User, :count)
  end

  it "validates password length greater than 8" do
    expect(User.create(email: "testbot@email.com",
                       password: "1234567")
          ).to_not be_valid

    expect(User.create(email: "testbot@email.com",
                       password: "12345678")
          ).to be_valid
  end

end
