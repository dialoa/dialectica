class AddLatexCodeToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :latex_code, :text, default: ""
  end
end
