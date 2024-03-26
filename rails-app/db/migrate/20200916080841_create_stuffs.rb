class CreateStuffs < ActiveRecord::Migration[6.0]
  def change
    create_table :stuffs do |t|
      t.string :filename, default: ""

      t.timestamps
    end
  end
end
