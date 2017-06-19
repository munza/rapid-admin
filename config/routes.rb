Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config.merge({class_name: Admin::User})
  ActiveAdmin.routes(self)
end
