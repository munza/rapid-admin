class Admin::Group < ApplicationRecord
  has_and_belongs_to_many :users, class_name: Admin::User
	has_many :abilities, as: :permissible, class_name: Admin::Ability
  has_many :permissions, through: :abilities
end
