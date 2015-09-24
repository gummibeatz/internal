class AddGoogleFormColumnsToEquipments < ActiveRecord::Migration
  def change
    change_table :equipment do |t|
      t.remove :type
      t.string :model
      t.string :account_name
      t.datetime :date_assigned
      t.string :signed_off_by
      t.boolean :policy_signed
      t.boolean :cc_info_on_google_form
      t.datetime :date_returned
      t.integer :return_condition
    end

  end
end
