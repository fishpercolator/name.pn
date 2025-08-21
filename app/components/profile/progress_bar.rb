# frozen_string_literal: true

class Components::Profile::ProgressBar < Components::Base
  attr_reader :user, :steps, :current_step

  def initialize(user:, steps:, current_step:)
    @user = user
    @steps = steps
    @current_step = current_step
  end

  def view_template
    ol(class: 'w-full flex flex-col sm:flex-row') do
      steps.each { step _1 }
    end
  end

  # Thanks to https://ishadeed.com/article/stepper-component-html-css/ for the inspiration
  def step(name)
    li(**mix({class: 'flex-1 flex sm:flex-col items-center after:w-1 after:h-8 sm:after:w-full sm:after:h-1 after:-order-1 after:relative after:top-4 sm:after:top-[22px] after:left-[22px] sm:after:left-[50%] last:after:invisible'}, {class: connector_class(name)})) do
      Link(**mix({class: 'flex sm:flex-col items-center flex-1 p-0 before:h-6 before:w-6 before:relative before:z-1 before:rounded-full before:m-2'}, {class: pip_class(name)}), href: helpers.wizard_path(name)) { t("profile.#{name}.title") }
    end
  end

  # If the step is in the future, return a different colour
  def connector_class(name)
    if current_step == name || future_steps.include?(name)
      'after:bg-slate-300 after:dark:bg-slate-700'
    else
      'after:bg-primary'
    end
  end
  def pip_class(name)
    if future_steps.include?(name)
      'before:bg-slate-300 before:dark:bg-slate-700'
    else
      'before:bg-primary'
    end
  end

  # Get only the steps after current_step
  def future_steps
    @future_steps ||= steps.slice(steps.index(current_step)+1..-1)
  end
end
