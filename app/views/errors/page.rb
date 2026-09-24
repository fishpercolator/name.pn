class Views::Errors::Page < Views::Base
  ISSUES = 'https://github.com/fishpercolator/name.pn/issues'.freeze
  SUPPORT = 'support@name.pn'.freeze

  def view_template
    Prose do
      PageTitle(t('.title'))
      p { t('.blurb') }
      support_links
    end
  end

  private

  def support_links
    ActionLinks do |actions|
      actions.link(ISSUES, icon: 'bug') { t('errors.support.report_a_bug') }
      actions.email_link(SUPPORT)
    end
  end
end
