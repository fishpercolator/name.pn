class Admin::ApplicationPolicy < ApplicationPolicy
  # Admins can do everything by default - normal users can do nothing
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user&.role_admin?
        scope.all
      else
        scope.none
      end
    end
  end
  
  def index?
    show?
  end

  def create?
    show?
  end

  def show?
    user&.role_admin?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end
end
