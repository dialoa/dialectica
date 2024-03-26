class AddNameToCodes < ActiveRecord::Migration[6.0]
  def change
    add_column :codes, :name, :string, default: ""
  end
end
