require 'rails_helper'

RSpec.describe Unit, type: :model do

  it { should belong_to(:cohort) }
  it { should have_many(:assessments) }

end

# == Schema Information
#
# Table name: units
#
#  id         :integer          not null, primary key
#  start_at   :datetime
#  end_at     :datetime
#  cohort_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
