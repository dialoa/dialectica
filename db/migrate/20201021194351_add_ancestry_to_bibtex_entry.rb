class AddAncestryToBibtexEntry < ActiveRecord::Migration[6.0]
  def change
    add_column :bibtex_entries, :ancestry, :string
    add_index :bibtex_entries, :ancestry
  end
end
