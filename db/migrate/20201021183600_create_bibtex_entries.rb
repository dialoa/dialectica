class CreateBibtexEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :bibtex_files do |t|
      t.text :content, default: ""

      t.timestamps
    end

    create_table :bibtex_entries do |t|
      t.text :content, default: ""
      t.belongs_to :bibtex_file

      t.timestamps
    end
  end
end
