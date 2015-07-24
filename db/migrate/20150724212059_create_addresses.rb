class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      t.integer :contact_id

      t.timestamps null: false
    end

    add_index :addresses, :contact_id
  end
end
