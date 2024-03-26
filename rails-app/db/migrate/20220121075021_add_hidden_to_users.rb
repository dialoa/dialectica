class AddHiddenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :hidden, :string, default: "no"
  end
end
