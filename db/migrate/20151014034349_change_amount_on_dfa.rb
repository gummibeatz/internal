class ChangeAmountOnDfa < ActiveRecord::Migration
  def change
    remove_column :sms_pledges, :amount
    add_column :sms_pledges, :amount, :float
  end
end
