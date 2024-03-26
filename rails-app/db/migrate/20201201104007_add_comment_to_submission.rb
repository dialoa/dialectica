class AddCommentToSubmission < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :comment, :text, default: ""
  end
end
