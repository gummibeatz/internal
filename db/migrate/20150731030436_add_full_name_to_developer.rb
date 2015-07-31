class AddFullNameToDeveloper < ActiveRecord::Migration
  def change
    add_column :developers, :full_name, :string
  end
end
