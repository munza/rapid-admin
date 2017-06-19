class Admin::Ability < ApplicationRecord
	belongs_to :permissible, polymorphic: true
	belongs_to :permission,  class_name: Admin::Permission
end
