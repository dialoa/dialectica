class CreateBlogPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :blog_posts do |t|
      t.string :title, default: ""
      t.text :description, default: ""
      t.text :keywords, default: ""
      t.text :search_field, default: ""
      t.text :content, default: ""

      t.timestamps
    end
  end
end
