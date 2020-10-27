class AddBibtexFileToCodes < ActiveRecord::Migration[6.0]
  def change
    add_reference :bibtex_files, :code, foreign_key: true
  end
end
