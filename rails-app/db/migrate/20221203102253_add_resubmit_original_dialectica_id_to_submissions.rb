class AddResubmitOriginalDialecticaIdToSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :resubmit_original_dialectica_id, :integer
  end
end
