class CreateAdminAbilities < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_abilities do |t|
    	t.references :permissible, polymorphic: true
    	t.references :permission
      t.timestamps
    end
  end
end
