class AddSearchFieldToHistories < ActiveRecord::Migration[6.0]
  def change
    add_column :histories, :search_field, :text, default: ""
  end
end
