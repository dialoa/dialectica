class AddCategoryToHistory < ActiveRecord::Migration[6.0]
  def change
    add_column :histories, :category, :string, default: ""
  end
end
