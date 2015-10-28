class AddRelationsToClickerAnswers < ActiveRecord::Migration
  def change
    add_column :clicker_answers, :developer_id, :integer
    add_column :clicker_answers, :clicker_question_id, :integer
  end
end
