# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base::establish_connection
ActiveRecord::Base::connection.tables.each do |table|
  next if table == 'schema_migrations'
  ActiveRecord::Base::connection.execute('SET FOREIGN_KEY_CHECKS=0;')
  ActiveRecord::Base::connection.execute("TRUNCATE #{table}")
  ActiveRecord::Base::connection.execute('SET FOREIGN_KEY_CHECKS=1;')
end

Admin::Module.create!(name: 'Admin',
											description: 'Authentication & authorization module to manage users, groups and permissions',
											meta: {
												resources: [
													{ name: 'User',
													  description: 'Manage admin users.',
													  permissions: [:manage, :read, :create, :update, :destroy]},
													{ name: 'Group',
													  description: 'Manage admin user\'s groups.',
													  permissions: [:manage, :read, :create, :update, :destroy]},
												  { name: 'Ability',
												    description: 'Manage ability of admin user & groups.',
												    permissions: [:manage, :read, :create, :update, :destroy]},
												],
											})

Admin::User.create!(first_name: 					 'Admin',
									  email: 								 'admin@example.com',
									  password: 						 'password',
									  password_confirmation: 'password',
									  is_admin: 						  true)
