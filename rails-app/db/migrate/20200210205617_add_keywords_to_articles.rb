class AddKeywordsToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :keywords, :text, default: ""
    add_column :articles, :description, :text, default: ""
  end
end
