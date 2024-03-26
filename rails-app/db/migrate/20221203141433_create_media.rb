class CreateMedia < ActiveRecord::Migration[6.0]
  def change
    create_table :media do |t|
      t.text :comment
      t.references :mediumable, polymorphic: true

      t.timestamps
    end
  end
end
