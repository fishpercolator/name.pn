class Components::Home::UrlCard < Components::Home::Card
  ACTION = 'dashboard-card__action h-auto flex-1 rounded-none border-0 py-3 font-normal text-secondary not-first:border-s not-first:border-base-300'.freeze

  def view_template
    div(class: 'md:col-span-2', data: { controller: 'url', url_copied_class: 'copy-button--copied' }) { super }
  end

  private

  def section = :url

  def step = :slug

  def blurb = nil

  def content
    p(class: 'break-words text-center text-2xl') { url }
    pronoun_urls if @user.pronoun_sets.any?
  end

  def url = @user.slug.present? ? b(data: { url_target: 'url' }) { user_url(@user) } : MissingValue(required: true)

  def pronoun_urls
    div(class: 'text-center text-muted') do
      p { i { t('.or_with_pronouns') } }
      @user.pronoun_sets.each { |set| p(class: 'break-words') { user_url(@user, nominative: set.nominative, oblique: set.oblique) } }
    end
  end

  def actions
    Button(href: profile_path(step), icon: 'pencil', variant: :ghost, class: ACTION) { t('actions.edit') }
    view_action
    copy_action
  end

  def view_action
    return unavailable_action('open-in-new') { t('.view_your_page') } unless @user.profile_complete?

    Button(href: user_url(@user), target: '_blank', icon: 'open-in-new', variant: :ghost, class: ACTION) { t('.view_your_page') }
  end

  def copy_action
    return unavailable_action('clipboard-outline') { t('.copy_to_clipboard') } unless @user.profile_complete?

    Button(id: 'copyButton', variant: :ghost, class: ['group', ACTION], data: { url_target: 'copyButton', action: 'url#copy' }) do
      span(class: 'contents group-[.copy-button--copied]:hidden') { labelled('clipboard-outline', t('.copy_to_clipboard')) }
      span(class: 'hidden group-[.copy-button--copied]:contents') { labelled('clipboard-check-outline', t('.copied')) }
    end
  end

  def unavailable_action(icon, &)
    Button(icon:, variant: :ghost, class: ACTION, disabled: true, title: t('.you_must_complete'), &)
  end

  def labelled(icon, text)
    Icon(icon)
    plain text
  end
end
