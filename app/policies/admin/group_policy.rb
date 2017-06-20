class Admin::GroupPolicy < ApplicationPolicy
	class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
  	super || @user.can?(:read, :admin, :group)
  end

  def show?
  	super || @user.can?(:read, :admin, :group)
  end

  def create?
  	super || @user.can?(:create, :admin, :group)
  end

  def update?
  	super || @user.can?(:update, :admin, :group)
  end

  def destroy?
  	super || @user.can?(:destroy, :admin, :group)
  end
end
