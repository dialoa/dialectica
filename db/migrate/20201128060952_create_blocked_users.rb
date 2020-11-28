class CreateBlockedUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :blocked_users do |t|
      t.belongs_to :submission
      t.belongs_to :user
      t.timestamps
    end
  end
end
