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
      :phonetic, :ipa, :slug, :likeness, :pronoun_example, :pronoun_style,
      :pronounless_style, :pronunciation_of, :noindex,
      :pronoun_set_ids => [],
      :links_attributes => [:id, :title, :url, :_destroy], 
      :alternate_names_attributes => [:id, :name, :category, :_destroy]
    ]
  end
    
end
