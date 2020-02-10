class ChangeLatexCode < ActiveRecord::Migration[6.0]
  def change
    rename_column :articles, :latex_code, :latex
  end
end
