class Components::PublicProfile::NameAndPronounCard < Components::Base
  def initialize(user, pronoun_sets)
    @user = user
    @pronoun_sets = pronoun_sets
  end

  def view_template
    div(class: 'napc rounded-box bg-primary p-8 text-center text-primary-content', data: { controller: 'napc' }) do
      h1(class: 'mb-2 text-[4rem] leading-none font-bold') { t('.hello') }
      subheading(t('.my_name_is'))
      name
      subheading(t('.my_pronouns_are'))
      pronouns
    end
  end

  private

  def subheading(text) = h2(class: 'my-2 text-[2rem] italic') { text }

  def name
    div(class: 'h-[9.5rem] rounded-box bg-base-100 px-8 py-4 font-handwriting text-[5rem] leading-[7.5rem] text-black') do
      p(class: 'inline-block whitespace-nowrap align-top', data: { napc_target: 'fit', max_size: 120 }) { @user.personal_name }
    end
  end

  def pronouns
    div(class: 'rounded-box bg-base-100 px-8 py-4 font-handwriting text-5xl leading-[4.5rem] text-black') do
      div(class: 'inline-block whitespace-nowrap align-top', data: { napc_target: 'fit' }) do
        pronoun_labels.each { |label| p { label } }
      end
    end
  end

  def pronoun_labels
    @user.pronounless_style? ? [t(".pronounless.#{@user.pronounless_style}")] : @pronoun_sets.map { it.to_s(@user) }
  end
end
