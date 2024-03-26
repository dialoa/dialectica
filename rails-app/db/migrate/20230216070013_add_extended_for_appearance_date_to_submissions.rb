class AddExtendedForAppearanceDateToSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :extended_appearance_date_for_send_to_external_referee, :string, default: "false"
  end
end
