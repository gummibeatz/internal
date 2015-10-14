class ChangeAmountToStringOnSmsPledge < ActiveRecord::Migration
  def change
    change_column :sms_pledges, :amount, :string
  end
end
