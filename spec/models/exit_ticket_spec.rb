require 'rails_helper'

RSpec.describe ExitTicket, type: :model do

  let(:developer) { create(:developer) }

  it { should belong_to(:developer) }

  it "creates a ticket" do
    expect {
      ticket = create(:exit_ticket, developer: developer)
    }.to change(ExitTicket, :count).by(1)
  end

  it "only has has record per developer per day" do
    ticket = create(:exit_ticket, developer: developer)
    ticket_two = build(:exit_ticket, developer: developer)
    expect(ticket_two).to_not be_valid
  end

end

