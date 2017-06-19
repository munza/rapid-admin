ActiveAdmin.register Admin::Group, namespace: :admin, as: 'group' do
	permit_params :name, :description

  config.sort_order = 'name_desc'

  filter :name

  index do
  	selectable_column
  	column :name
  	column :description
  	actions
  end

  form do |f|
  	f.inputs 'Group Details' do
	  	f.input :name
	  	f.input :description, input_html: { rows: 4 }
	  end
	  f.actions
  end

  show do
  	attributes_table do
  		row :name
  		row :description
  	end
  end
end
