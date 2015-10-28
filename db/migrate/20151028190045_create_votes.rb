class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, index: true, foreign_key: true, unique: true
      t.references :clicker_answer, index: true, foreign_key: true, unique: true
      t.timestamps null: false
    end
  end
end
