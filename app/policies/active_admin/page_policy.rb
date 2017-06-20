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
  	else
  		false
  	end
  end
end
