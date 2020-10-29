class AddYamlToCodes < ActiveRecord::Migration[6.0]
  def change
    add_column :codes, :yaml, :text, default: ""
  end
end
