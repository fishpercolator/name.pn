class UserPolicy < ApplicationPolicy
  def show?
    record.profile_complete?
  end
  
  # All profile wizard actions are 'update'
  def update?
    user == record
  end
  
  def permitted_attributes
    [
      :full_name, :personal_name, :formal_name, :envelope_name,
      :phonetic, :slug, :pronoun_set_ids => []
    ]
  end
    
end
