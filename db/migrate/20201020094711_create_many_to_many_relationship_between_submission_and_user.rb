class CreateManyToManyRelationshipBetweenSubmissionAndUser < ActiveRecord::Migration[6.0]
  def change
    create_table :submission_users do |t|
      t.belongs_to :submission
      t.belongs_to :user
      t.timestamps
    end
  end
end
