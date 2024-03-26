class CreateSuggestionSubmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :suggestion_submissions do |t|
      t.belongs_to :user
      t.belongs_to :submission

      t.timestamps
    end
  end
end
