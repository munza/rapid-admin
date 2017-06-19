ActiveAdmin.register_page "Dashboard" do
  menu false

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do

      column do
        Admin::Module.all.each do |m|
          panel m.name do
            table_for m.meta['resources'] do
              column { |r| r['name'] }
              column { |r| r['description'] }
              column { |r| link_to 'Manage', "/#{m.name.underscore}/#{r['name'].pluralize.underscore}" }
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
