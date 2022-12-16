class QuestionAnswer < ApplicationRecord
  belongs_to :submission, optional: true
end
