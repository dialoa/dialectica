class AddWithDrawnToSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :withdrawn, :string, default: "false"
  end
end
