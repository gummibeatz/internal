class AddLinkedinUrlToDevelopers < ActiveRecord::Migration
  def change
    add_column :developers, :linkedin_url, :string
  end
end
