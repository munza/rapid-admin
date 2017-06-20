class Admin::PermissionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def manage?
  	@user.is_admin? || @user.can?(:manage, :admin, :permission)
  end
end
