ActiveAdmin.register Admin::User, namespace: :admin, as: 'user' do
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

  action_item :show_history, only: :show, if: proc { current_admin_user.is_admin? } do
    link_to 'Show History', history_admin_user_path(resource)
  end

  form partial: 'form'

  member_action :history do
    raise ActiveAdmin::AccessDenied(current_admin_user, :history, resource) unless current_admin_user.is_admin?
    versions = PaperTrail::Version.where(item_type: 'Admin::User', item_id: params[:id])
    render "layouts/history", locals: {versions: versions}
  end

  controller do
    def find_resource
      @user = Admin::User.includes(:versions).find(params[:id])
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
