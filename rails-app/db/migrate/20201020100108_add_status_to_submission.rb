class AddStatusToSubmission < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :status, :string, default: "submitted"
  end
end
