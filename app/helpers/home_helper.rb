module HomeHelper
  
  def you_must
    content_tag(:span, class: 'icon has-text-warning is-medium') do
      content_tag(:i, '', class: 'mdi mdi-24px mdi-alert')
    end +
    content_tag(:span, t('home.user_home.you_must'), class: 'has-text-warning has-text-weight-bold')
  end
  
  def not_set
    content_tag(:span, t('home.user_home.not_set'), class: 'is-italic has-text-grey')
  end
  
end
