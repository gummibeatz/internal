class CreateSmsPledges < ActiveRecord::Migration
  def change
    create_table :sms_pledges do |t|
      t.integer :amount
      t.integer :sms_donor_id
      t.text :message

      t.timestamps null: false
    end
  end
end
