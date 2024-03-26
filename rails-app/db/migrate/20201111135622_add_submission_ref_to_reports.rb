class AddSubmissionRefToReports < ActiveRecord::Migration[6.0]
  def change
    add_reference :reports, :submission, foreign_key: true
  end
end
