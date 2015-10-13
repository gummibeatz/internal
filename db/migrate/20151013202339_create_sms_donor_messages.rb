class CreateSmsDonorMessages < ActiveRecord::Migration
  def change
    create_table :sms_donor_messages do |t|
      t.text    :message
      t.string  :sms_sid
      t.string  :account_sid
      t.string  :sms_message_sid
      t.string  :message_sid
      t.integer :sms_donor_id

      t.timestamps null: false
    end
  end
end
