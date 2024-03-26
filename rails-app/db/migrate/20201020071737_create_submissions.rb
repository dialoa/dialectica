class CreateSubmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :submissions do |t|
      t.string :title, default: ""
      t.string :area, default: ""
      t.string :firstname, default: ""
      t.string :lastname, default: ""

      t.timestamps
    end
  end
end
