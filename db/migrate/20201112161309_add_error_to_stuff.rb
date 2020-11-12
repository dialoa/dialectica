class AddErrorToStuff < ActiveRecord::Migration[6.0]
  def change
    add_column :stuffs, :error, :text, default: ""
  end
end
