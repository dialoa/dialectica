class AddBibtexFileToCode < ActiveRecord::Migration[6.0]
  def change
    add_column :codes, :bibtex, :text, default: ""
  end
end
