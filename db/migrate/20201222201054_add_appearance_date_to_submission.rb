class AddAppearanceDateToSubmission < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :appearance_date, :date
  end
end
