class ClientPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end
  
  def create?
    record.user == user
  end
  
  def destroy?
    create?
  end
  
  def permitted_attributes
    [:name]
  end
end
