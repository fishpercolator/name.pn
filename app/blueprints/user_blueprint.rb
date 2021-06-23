class UserBlueprint < Blueprinter::Base
  identifier :slug
  
  fields :personal_name, :full_name, :formal_name, :envelope_name
end
