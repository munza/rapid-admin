ActiveAdmin.register Admin::Group, namespace: :admin, as: 'group' do
	permit_params :name, :description
end
