class AddFieldsToSubmission < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :country, :string, default: ""
    add_column :submissions, :gender, :string, default: ""
    add_column :submissions, :other_authors, :string, default: ""
  end
end
