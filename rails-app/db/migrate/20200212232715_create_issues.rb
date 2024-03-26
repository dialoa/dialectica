class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues do |t|
      t.string :title, default: ""
      t.date :published_at
      t.text :description, default: ""

      t.timestamps
    end
    add_reference :articles, :issue, index: true
  end
end
