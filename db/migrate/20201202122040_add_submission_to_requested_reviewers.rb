class AddSubmissionToRequestedReviewers < ActiveRecord::Migration[6.0]
  def change
    add_reference :requested_reviewers, :submission, null: false, foreign_key: true
  end
end
