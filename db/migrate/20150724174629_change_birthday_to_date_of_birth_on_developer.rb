class ChangeBirthdayToDateOfBirthOnDeveloper < ActiveRecord::Migration
  def change
    rename_column :developers, :birthday, :date_of_birth
  end
end
