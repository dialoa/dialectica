class AddReferenceToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :blog_posts, :user, foreign_key: true
  end
end
