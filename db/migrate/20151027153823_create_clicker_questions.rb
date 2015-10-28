class CreateClickerQuestions < ActiveRecord::Migration
  def change
    create_table :clicker_questions do |t|

      t.timestamps null: false
    end
  end
end
