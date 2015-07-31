require 'test_helper'

class ExitTicketTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: exit_tickets
#
#  id                                     :integer          not null, primary key
#  certainty                              :integer          default(0)
#  overall_quality                        :integer          default(0)
#  difficulty                             :integer          default(0)
#  instructors_ability_to_communicate     :integer          default(0)
#  instructors_ability_to_stimulate       :integer          default(0)
#  pace_and_speed                         :integer          default(0)
#  understanding                          :integer          default(0)
#  recall_information_from_previous_class :integer          default(0)
#  additional_comments                    :string
#  developer_id                           :integer
#  created_at                             :datetime         not null
#  updated_at                             :datetime         not null
#  original_form_url                      :string
#  submitted_at                           :datetime
#
