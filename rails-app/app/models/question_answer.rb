class QuestionAnswer < ApplicationRecord
  belongs_to :submission, optional: true

  def self.placeholders(question_answer = nil)
    {
      "question_answer.question": question_answer && question_answer.question ? question_answer.question : "What is your concept of knowledge?",
      "question_answer.answer": question_answer && question_answer.answer ? question_answer.answer : "My concept of knowledge is justified true belief.",
    }
  end

end
