class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :author, default: ""
      t.text :content, deafult: ""
      t.string :title, default: ""
      t.date :published_at

      t.timestamps
    end
  end
end
