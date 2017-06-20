class Admin::Group < ApplicationRecord
  has_paper_trail

  has_and_belongs_to_many :users, class_name: 'Admin::User'
	has_many :abilities, as: :permissible, class_name: 'Admin::Ability'
  has_many :permissions, through: :abilities

  validates :name, presence: true, uniqueness: true
end
