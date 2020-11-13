class AddDeadToSubmission < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :dead, :string, default: "false"
  end
end
