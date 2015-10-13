class CreateSmsDonors < ActiveRecord::Migration
  def change
    create_table :sms_donors do |t|
      t.string :phone_number
      t.string :name
      t.string :state
      t.string :city
      t.string :zip
      t.string :country

      t.timestamps null: false
    end

    add_index :sms_donors, :phone_number
  end
end
