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
#  id                :integer          not null, primary key
#  certainty         :integer          default(0)
#  quality           :integer          default(0)
#  difficulty        :integer          default(0)
#  communication     :integer          default(0)
#  stimulation       :integer          default(0)
#  pace_and_speed    :integer          default(0)
#  understanding     :integer          default(0)
#  recall            :integer          default(0)
#  comments          :string
#  developer_id      :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  original_form_url :string
#  submitted_at      :datetime
#  questions         :text
#  score             :float
#  summary_form_url  :string
#  type              :integer          default(0)
#
