class CreateJsons < ActiveRecord::Migration[6.0]
  def change
    create_table :jsons do |t|
      t.jsonb :content

      t.timestamps
    end
  end
end
