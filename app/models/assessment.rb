class Assessment < ActiveRecord::Base

  belongs_to :unit
  belongs_to :developer

end
