class MikeIsStupid < ActiveRecord::Migration
  def change
    add_column :addresses, :user_id, :integer
    remove_column :addresses, :contact_id
  end
end
