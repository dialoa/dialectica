class AddCategoryToBlogPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :blog_posts, :category, :string, default: ""
  end
end
