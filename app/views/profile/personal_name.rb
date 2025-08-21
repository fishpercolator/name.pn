# frozen_string_literal: true

class Views::Profile::PersonalName < Views::Base
  include Phlex::Rails::Helpers::FormFor

  controller_variable :user

  def view_template
    ShellLayout do
      render Profile::ProgressBar.new(user: @user, steps: helpers.wizard_steps, current_step: helpers.step)
      form_for(@user, url: helpers.wizard_path, method: :patch) do |f|
      end
    end
  end
end
