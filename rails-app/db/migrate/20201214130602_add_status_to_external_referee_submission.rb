class AddStatusToExternalRefereeSubmission < ActiveRecord::Migration[6.0]
  def change
    add_column :external_referee_submissions, :status, :string, default: "no answer"
    add_column :external_referee_submissions, :date_of_answer, :date
  end
end
