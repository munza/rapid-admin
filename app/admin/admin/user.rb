ActiveAdmin.register Admin::User, namespace: :admin, as: 'user' do
  include VersionHistory

  permit_params :first_name, :last_name,
                :email, :password, :password_confirmation,
                :is_admin,
                group_ids: [], additional_permission_ids: []

  config.sort_order = 'first_name_desc'

  scope :all
  scope :admin

  filter :first_name_or_last_name_cont, label: 'Name (Contains)'
  filter :email
  filter :last_sign_in_at

  index do
    selectable_column
    column :name
    column :email
    column(:admin) { |u| u.is_admin }
    column :current_sign_in_at
    column :last_sign_in_at
    actions
  end

  show { render 'show' }

  form partial: 'form'

  controller do
    def find_resource
      @resource = Admin::User.includes(:versions).find(params[:id])
    end

    def update_resource(object, attributes)
      attributes.each do |attr|
        if attr[:password].blank? and attr[:password_confirmation].blank?
          attr.delete :password
          attr.delete :password_confirmation
        end
      end
      object.send :update_attributes, *attributes
    end
  end
end
