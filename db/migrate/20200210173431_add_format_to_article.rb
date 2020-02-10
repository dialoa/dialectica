class AddFormatToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :format, :string, default: "html"
  end
end
