require 'rails_helper'

RSpec.describe Assessment, type: :model do

  it { should belong_to(:developer) }
  it { should belong_to(:unit) }

end
