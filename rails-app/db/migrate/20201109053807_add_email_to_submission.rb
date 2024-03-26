class AddEmailToSubmission < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :email, :string, default: ""
  end
end
