class CreateClickerAnswerChoices < ActiveRecord::Migration
  def change
    create_table :clicker_answer_choices do |t|

      t.timestamps null: false
    end
  end
end
