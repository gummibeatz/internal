class Drop < ActiveRecord::Migration
  def change
    drop_table :developers
  end
end
