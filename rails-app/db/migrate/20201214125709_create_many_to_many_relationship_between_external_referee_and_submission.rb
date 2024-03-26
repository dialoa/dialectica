class CreateManyToManyRelationshipBetweenExternalRefereeAndSubmission < ActiveRecord::Migration[6.0]
  def change
    create_table :external_referee_submissions do |t|
      t.belongs_to :external_referee
      t.belongs_to :submission
      t.timestamps
    end
  end
end
