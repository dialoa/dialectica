class AddReferenceToJson < ActiveRecord::Migration[6.0]
  def change
    add_reference :jsons, :bibtex_entry, foreign_key: true
  end
end
