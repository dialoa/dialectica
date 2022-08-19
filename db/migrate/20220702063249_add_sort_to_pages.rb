class AddSortToPages < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :sort, :integer, default: 0
  end
end
