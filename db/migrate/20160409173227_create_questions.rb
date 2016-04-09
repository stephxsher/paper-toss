class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|

      t.string :text
      t.string :type

      t.timestamps null: false
    end
  end
end
