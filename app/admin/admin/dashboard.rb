ActiveAdmin.register_page 'Dashboard', namespace: :admin do
	menu false
  content do
    columns do
    	column do
    		panel 'Admin' do
    			Admin::Module.where(name: 'Admin').each do |m|
    				text_node m.description
            table do
              thead do
                th 'Name'
                th 'Description'
                th
              end
              tbody do
                m.meta['resources'].each do |r|
                  if r['admin'] && current_admin_user.has_resource_access?(m.name.underscore, r['name'].underscore)
                    tr do
                      td r['name']
                      td r['description']
                      td link_to 'Manage', "/#{m.name.underscore}/#{r['name'].pluralize.underscore}"
                    end
                  end
                end
              end
            end
    			end
    		end
    	end

		  column do
		  end

		  column do
		  end
    end
  end
end
