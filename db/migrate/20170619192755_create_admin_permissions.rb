class CreateAdminPermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_permissions do |t|
      t.string :module
      t.string :resource
      t.string :action
      t.text :description, null: true

      t.timestamps
    end
  end
end
