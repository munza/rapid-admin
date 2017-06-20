class Admin::Group < ApplicationRecord
  has_and_belongs_to_many :users, class_name: 'Admin::User',
                                  before_add: :touch_with_version,
                                  before_remove: :touch_with_version

	has_many :abilities, as: :permissible,
											 class_name: 'Admin::Ability',
                       before_add: :touch_with_version,
                       before_remove: :touch_with_version

  has_many :permissions, through: :abilities,
                         before_add: :touch_with_version,
                         before_remove: :touch_with_version

  has_paper_trail meta: { association_object: :paper_trail_associations }

  validates :name, presence: true, uniqueness: true

  def paper_trail_associations
    { abilities: abilities,
      permissions: permissions }
  end
end
