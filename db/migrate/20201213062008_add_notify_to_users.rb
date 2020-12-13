class AddNotifyToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :notify_me_when_i_am_suggested_as_an_internal_referee, :string, default: "no"
    add_column :users, :notify_me_when_something_happens_to_my_fish, :string, default: "no"
  end
end
