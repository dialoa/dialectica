class AddAcceptedAndRejectedToSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :accepted, :string, default: "false"
    add_column :submissions, :rejected, :string, default: "false"
  end
end
