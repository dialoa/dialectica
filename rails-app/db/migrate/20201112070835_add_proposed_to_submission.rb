class AddProposedToSubmission < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :proposed, :string, default: "false"
  end
end
