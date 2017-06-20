class Admin::Permission < ApplicationRecord
	has_many :abilities, dependent: :destroy, class_name: 'Admin::Ability'
  has_many :groups, through: :abilities, source: :permissible, source_type: 'Admin::Group'
  has_many :users, through: :abilities, source: :permissible, source_type: 'Admin::User'

  def name
  	"#{self.module} | #{resource} | #{action}"
  end
end
