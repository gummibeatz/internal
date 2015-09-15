require 'rails_helper'

RSpec.describe Cohort, type: :model do

  it { should validate_uniqueness_of :version }

  it { should have_many :developers }
  it { should have_many :units }
  it { should have_many :assignments }

end
