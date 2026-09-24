class Views::Layouts::Application < Views::Layouts::Base
  def view_template(&)
    document('flex min-h-screen flex-col bg-base-200') do
      header do
        SiteNavbar()
        FlashMessages()
      end
      main(class: 'flex grow flex-col') { page(&) }
      footer { SiteFooter() }
      yield(:modal)
    end
  end

  private

  def page = yield
end
