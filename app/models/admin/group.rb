class Admin::Group < ApplicationRecord
	has_and_belongs_to_many :users, class_name: Admin::User
end
