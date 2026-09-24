module HomeHelper
  
  def you_must
    content_tag(:span, class: 'inline-flex items-center gap-1 font-bold text-warning') do
      icon('alert', class: 'size-6 fill-current') + t('home.user_home.you_must')
    end
  end
  
  def not_set
    content_tag(:span, t('home.user_home.not_set'), class: 'italic text-muted')
  end
  
end
