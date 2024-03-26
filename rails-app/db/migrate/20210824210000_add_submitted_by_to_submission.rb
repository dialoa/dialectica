class AddSubmittedByToSubmission < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :submitted_by_user_id, :integer
  end
end
