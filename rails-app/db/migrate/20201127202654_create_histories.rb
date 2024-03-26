class CreateHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :histories do |t|
      t.text :content, default: ""
      t.belongs_to :submission
      t.belongs_to :user

      t.timestamps
    end
  end
end
