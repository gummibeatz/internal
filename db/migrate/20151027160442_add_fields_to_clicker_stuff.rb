class AddFieldsToClickerStuff < ActiveRecord::Migration

  def change

    change_table :clicker_questions do |t|
      t.text :question
      t.integer :correct_choice
    end

    change_table :clicker_answers do |t|
      t.boolean :is_correct
      t.integer :choice      
      t.text :answer
    end

  end

end
