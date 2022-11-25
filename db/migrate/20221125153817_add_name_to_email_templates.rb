class AddNameToEmailTemplates < ActiveRecord::Migration[6.0]
  def change
    add_column :email_templates, :name, :string, default: ""
  end
end
