class AddGenderToDeveloper < ActiveRecord::Migration
  def change
    add_column :developers, :gender, :integer
    add_index :developers, :gender
  end

end
