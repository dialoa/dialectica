class AddTwoPropositionToSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :proposed_for_acceptance, :string, default: "false"
    add_column :submissions, :proposed_for_rejection, :string, default: "false"
  end
end
