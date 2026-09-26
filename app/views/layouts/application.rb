class Views::Layouts::Application < Views::Layouts::Base
  include Phlex::Rails::Helpers::Flash

  def view_template(&)
    document('flex min-h-screen flex-col bg-base-200') do
      header do
        render Components::Shared::SiteNavbar.new
        FlashMessages(flash.to_hash)
      end
      main(class: 'flex grow flex-col') do
        page(&)
      end
      footer { render Components::Shared::SiteFooter.new }
      yield(:modal)
    end
  end

  protected

  # Subclasses override this to wrap the page content in their own container
  def page = yield
end
