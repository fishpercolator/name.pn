class Components::UI::PronounExample < Components::Base
  def initialize(pronoun_set, user, inflection)
    @pronoun_set = pronoun_set
    @user = user
    @inflection = inflection
  end

  def view_template
    raw t("pronoun_examples.#{@user.pronoun_example}.#{@inflection}_html", **@pronoun_set.example_values(@inflection, @user))
  end
end
