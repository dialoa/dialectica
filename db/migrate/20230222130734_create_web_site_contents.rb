class CreateWebSiteContents < ActiveRecord::Migration[6.0]
  def change
    create_table :web_site_contents do |t|
      t.string :title, default: ""
      t.text :content, default: ""
      t.string :identifier, default: ""

      t.timestamps
    end
  end
end
