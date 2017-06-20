class ActiveAdmin::PagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
  	case @record.namespace.name
  	when :root
  		true
    when :admin
      @user.has_module_access?(:admin)
  	else
  		false
  	end
  end
end
