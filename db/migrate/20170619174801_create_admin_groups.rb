class CreateAdminGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_groups do |t|
      t.string :name,      unique: true
      t.text :description, null: true

      t.timestamps
    end

    create_table :admin_groups_users, id: false do |t|
    	t.references :group
    	t.references :user
    end
  end
end
