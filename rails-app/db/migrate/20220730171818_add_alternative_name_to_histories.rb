class AddAlternativeNameToHistories < ActiveRecord::Migration[6.0]
  def change
    add_column :histories, :alternative_name, :string, default: ""
  end
end
