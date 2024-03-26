class CreateRequestedReviewers < ActiveRecord::Migration[6.0]
  def change
    create_table :requested_reviewers do |t|
      t.string :firstname, default: ""
      t.string :lastname, default: ""
      t.string :email, default: ""
      t.string :status, default: "open"

      t.timestamps
    end
  end
end
