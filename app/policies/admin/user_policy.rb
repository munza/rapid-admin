class Admin::UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    super || @user.can?(:read, :admin, :user)
  end

  def show?
    super || @user.can?(:read, :admin, :user)
  end

  def create?
    super || @user.can?(:create, :admin, :user)
  end

  def update?
  	@record.id == @user.id || super
  end

  def destroy?
  	@record.id != @user.id && super
  end
end
