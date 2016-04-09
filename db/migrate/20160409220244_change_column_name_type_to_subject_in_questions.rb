class ChangeColumnNameTypeToSubjectInQuestions < ActiveRecord::Migration
  def change
    rename_column :questions, :type, :subject
  end
end
