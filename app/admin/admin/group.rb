ActiveAdmin.register Admin::Group, namespace: :admin, as: 'group' do
	permit_params :name, :description,
                permission_ids: []

  config.sort_order = 'name_desc'

  filter :name

  index do
  	selectable_column
  	column :name
  	column :description
  	actions
  end

  show { render 'show' }
  form partial: 'form'
end
