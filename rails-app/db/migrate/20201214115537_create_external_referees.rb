class CreateExternalReferees < ActiveRecord::Migration[6.0]
  def change
    create_table :external_referees do |t|
      t.string :firstname, default: ""
      t.string :lastname, default: ""
      t.string :email, default: ""

      t.timestamps
    end
  end
end
