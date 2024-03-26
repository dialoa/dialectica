class AddSearchFieldToSubmission < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :search_field, :text, default: ""
  end
end
