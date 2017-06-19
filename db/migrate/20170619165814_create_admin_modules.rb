class CreateAdminModules < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_modules do |t|
      t.string :name,				 unique: true
      t.string :description, null: true
      t.json :meta,					 null: false

      t.timestamps
    end
  end
end
