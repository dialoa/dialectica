class CreateQuestionAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :question_answers do |t|
      t.text :question, default: ""
      t.text :answer, default: ""
      t.belongs_to :submission

      t.timestamps
    end
  end
end
