ActiveAdmin.register_page "Dashboard" do
  menu false

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do

      column do
        Admin::Module.all.each do |m|
          if current_admin_user.has_module_access?(m.name.underscore)
            panel m.name do
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
          else
            panel 'Modules' do
              text_node 'You do not have permission to any module...'
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
