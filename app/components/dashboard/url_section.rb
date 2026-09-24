class Components::Dashboard::UrlSection < Components::Dashboard::Section
  def view_template
    div(class: 'md:col-span-2', data: { controller: 'url', url_copied_class: 'swap-active' }) { super }
  end

  protected

  def section_name = :url

  def step = :slug

  def blurb = nil

  def content
    p(class: 'break-words text-center text-2xl') { url }
    pronoun_urls if @user.pronoun_sets.any?
  end

  def actions(card)
    edit_action(card)
    view_action(card)
    copy_action(card)
  end

  private

  def url = @user.slug.present? ? b(data: { url_target: 'url' }) { user_url(@user) } : MissingValue(required: true)

  def pronoun_urls
    div(class: 'text-center text-muted') do
      p { i { t('.or_with_pronouns') } }
      @user.pronoun_sets.each { |set| p(class: 'break-words') { user_url(@user, nominative: set.nominative, oblique: set.oblique) } }
    end
  end

  def shareable? = @user.profile_complete?

  def edit_action(card) = card.action(href: profile_path(step), icon: 'pencil') { t('actions.edit') }

  def view_action(card)
    return unavailable_action(card, 'open-in-new') { t('.view_your_page') } unless shareable?

    card.action(href: user_url(@user), target: '_blank', icon: 'open-in-new') { t('.view_your_page') }
  end

  def copy_action(card)
    return unavailable_action(card, 'clipboard-outline') { t('.copy_to_clipboard') } unless shareable?

    card.action(id: 'copyButton', data: { url_target: 'copyButton', action: 'url#copy' }) do
      Swap do |swap|
        swap.off { copy_state('clipboard-outline', t('.copy_to_clipboard')) }
        swap.on { copy_state('clipboard-check-outline', t('.copied')) }
      end
    end
  end

  def copy_state(icon, text)
    Icon(icon)
    plain text
  end

  def unavailable_action(card, icon, &)
    card.action(icon:, disabled: true, title: t('.you_must_complete'), &)
  end
end
