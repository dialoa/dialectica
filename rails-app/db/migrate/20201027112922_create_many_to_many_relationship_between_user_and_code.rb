class CreateManyToManyRelationshipBetweenUserAndCode < ActiveRecord::Migration[6.0]
  def change
    create_table :user_codes do |t|
      t.belongs_to :user
      t.belongs_to :code
      t.timestamps
    end
  end
end
