require 'rails_helper'

RSpec.describe Developer, type: :model do

  it { should have_many(:exit_tickets) }

  it "creates a developer" do
    expect {
       developer = create(:developer)
    }.to change(Developer, :count).by(1)
  end

end
