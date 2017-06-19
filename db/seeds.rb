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

modules = [
	{ name: 'Admin',
	  description: 'Authentication & authorization module to manage users, groups and permissions',
	  meta: {
	    resources: [
		 	  { name: 'User',
			    description: 'Manage admin users.',
			    permissions: [:manage, :read, :create, :update, :destroy]},
			  { name: 'Group',
			    description: 'Manage admin user\'s groups.',
			    permissions: [:manage, :read, :create, :update, :destroy]},
		    { name: 'Permission',
		      description: 'Manage permission of admin user & groups.',
		      permissions: [:manage, :assign, :revoke]},
		  ],
	  },
	},
]

Admin::Module.create!(modules)

Admin::User.create!(first_name: 					 'Admin',
									  email: 								 'admin@example.com',
									  password: 						 'password',
									  password_confirmation: 'password',
									  is_admin: 						  true)

modules.each do |m|
	m[:meta][:resources].each do |r|
		r[:permissions].each do |p|
			Admin::Permission.create!('module'      => m[:name].underscore,
																'resource'    => r[:name].underscore,
																'action'      => p.underscore)
		end
	end
end
