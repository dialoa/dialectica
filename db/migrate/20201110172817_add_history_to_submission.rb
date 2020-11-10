class AddHistoryToSubmission < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :history, :text, default: ""
  end
end
