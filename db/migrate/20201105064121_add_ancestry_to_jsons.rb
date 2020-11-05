class AddAncestryToJsons < ActiveRecord::Migration[6.0]
  def change
    add_column :jsons, :ancestry, :string
    add_index :jsons, :ancestry
  end
end
