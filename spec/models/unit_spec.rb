require 'rails_helper'

RSpec.describe Unit, type: :model do

  it { should belong_to(:cohort) }
  it { should have_many(:assessments) }

end
