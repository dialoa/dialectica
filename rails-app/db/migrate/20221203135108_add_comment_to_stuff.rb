class AddCommentToStuff < ActiveRecord::Migration[6.0]
  def change
    add_column :stuffs, :comment, :text, default: ""
  end
end
