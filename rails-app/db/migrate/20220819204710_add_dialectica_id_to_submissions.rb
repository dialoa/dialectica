class AddDialecticaIdToSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :dialectica_id, :integer
  end
end
