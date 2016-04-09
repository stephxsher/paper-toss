class CreateConversationQuestions < ActiveRecord::Migration
  def change
    create_table :conversation_questions do |t|

      t.integer :conversation_id
      t.integer :question_id

      t.timestamps null: false
    end
  end
end
