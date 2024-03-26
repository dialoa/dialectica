class AddProposedForDiscussionToSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :proposed_for_discussion, :string, default: ""
  end
end
