class AddStatusToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :statuts, :string, default: ""
  end
end
