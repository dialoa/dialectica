class CreateEmailTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :email_templates do |t|
      t.text :content, default: ""

      t.timestamps
    end
  end
end
