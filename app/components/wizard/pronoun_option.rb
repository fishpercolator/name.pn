class Components::Wizard::PronounOption < Components::Base
  def initialize(row)
    @row = row
  end

  def view_template
    @row.hidden :pronoun_set_id
    div(class: 'profile-pronouns__option') do
      label(for: @row.id_for(:_destroy), class: 'flex cursor-pointer items-start gap-2 text-xl font-bold') do
        span(class: 'hidden cursor-grab', data: { pronoun_form_target: 'handle' }) { Icon('drag', class: 'size-6 fill-current') }
        @row.input :position, as: :number, title: t('.position_hint'), class: 'input-sm w-16', data: { pronoun_form_target: 'position' }
        @row.input :_destroy, as: :checkbox, checked: selected?, checked_value: '0', unchecked_value: '1', class: 'mt-0.5', data: { pronoun_form_target: 'option' }
        span do
          plain pronoun_set.to_s
          Hint(class: 'hint block font-normal') { example }
        end
      end
    end
  end

  private

  def selected? = @row.object.persisted?

  def pronoun_set = @row.object.pronoun_set

  def example
    t('.example_html', name: @row.object.user.personal_name, nominative: pronoun_set.nominative, oblique: pronoun_set.oblique, copula: pronoun_set.copula)
  end
end
