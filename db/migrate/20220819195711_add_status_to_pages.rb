class AddStatusToPages < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :status, :string, default: "visible"
  end
end
