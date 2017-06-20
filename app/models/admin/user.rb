class Admin::User < ApplicationRecord
  has_and_belongs_to_many :groups, class_name: 'Admin::Group',
                                   before_add: :touch_with_version,
                                   before_remove: :touch_with_version

  has_many :abilities, as: :permissible, class_name: 'Admin::Ability',
                                         before_add: :touch_with_version,
                                         before_remove: :touch_with_version

  has_many :group_permissions, through: :groups, source: :permissions

  has_many :additional_permissions, through: :abilities,
                                    source: :permission,
                                    before_add: :touch_with_version,
                                    before_remove: :touch_with_version

  has_paper_trail meta: { association_object: :paper_trail_associations }

  devise :database_authenticatable,
       :recoverable, :rememberable, :trackable, :validatable
       # :confirmable, :lockable, :timeoutable, :omniauthable

  after_create { |admin| admin.send_reset_password_instructions }

  scope :admin, ->{ where(is_admin: true) }

  validates :first_name, presence: true

  def paper_trail_associations
    { groups: groups,
      abilities: abilities,
      additional_permissions: additional_permissions }
  end

  def password_required?
    new_record? ? false : super
  end

  def name
  	"#{first_name} #{last_name}"
  end

  def is_admin?
  	is_admin
  end

  def can?(action, mod, resource = :all)
    has_additional_permission?(action, mod, resource) || has_role_permission?(action, mod, resource)
  end

  def cannot?(action, mod, resource = :all)
    !can(action, mod, resource)
  end

  def has_module_access?(mod)
    return true if is_admin?
    additional_permissions.any? { |p| p.module == mod.to_s } ||
    group_permissions.any? { |p| p.module == mod.to_s }
  end

  def has_resource_access?(mod, resource = :all)
    return true if is_admin?
    additional_permissions.any? { |p| p.module == mod.to_s && p.resource == resource.to_s } ||
    group_permissions.any? { |p| p.module == mod.to_s && p.resource == resource.to_s }
  end

  def has_additional_permission?(action, mod, resource = :all)
    additional_permissions.any? do |p|
      p.module == mod.to_s && p.resource == resource.to_s && (
        p.action == 'manage' || p.action == action.to_s )
    end
  end

  def has_role_permission?(action, mod, resource = :all)
    group_permissions.any? do |p|
      p.module == mod.to_s && p.resource == resource.to_s && (
        p.action == 'manage' || p.action == action.to_s )
    end
  end
end
