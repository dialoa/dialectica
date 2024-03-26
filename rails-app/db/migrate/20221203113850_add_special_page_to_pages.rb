class AddSpecialPageToPages < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :special_page, :string, default: ""
  end
end
