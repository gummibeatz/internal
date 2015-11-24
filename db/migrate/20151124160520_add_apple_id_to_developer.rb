class AddAppleIdToDeveloper < ActiveRecord::Migration
  def change
    add_column :developers, :apple_id, :string
  end
end
