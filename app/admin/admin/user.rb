ActiveAdmin.register Admin::User, namespace: :admin, as: 'user' do
  permit_params :first_name, :last_name,
                :email, :password, :password_confirmation,
                :is_admin

  config.sort_order = 'first_name_desc'

  scope :all
  scope :admin

  index do
    selectable_column
    column :name
    column :email
    column(:admin) { |u| u.is_admin }
    column :current_sign_in_at
    column :last_sign_in_at
    actions
  end

  filter :first_name_or_last_name_cont, label: 'Name (Contains)'
  filter :email
  filter :last_sign_in_at

  form do |f|
    f.inputs 'User Details' do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.inputs 'Groups' do
    end
    f.actions
  end

end
