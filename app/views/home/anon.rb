# frozen_string_literal: true

class Views::Home::Anon < Views::Base
  def view_template
    div(class: 'flex justify-center') { Home::Logo() }
    div(class: 'grid md:grid-cols-3 gap-6 my-20') do
      %w[promo1 promo2 promo3].each do |p|
        args = %i[title icon_name description].to_h {[_1, t(_1, scope: ['views.home.anon', p])]}
        promo(**args)
      end
    end
  end

  private

  def promo(title:, icon_name:, description:)
    div(class: 'rounded-xl border bg-background shadow p-4 md:p-6 grid grid-cols-[48px_auto] gap-3 items-center') do
      icon(icon_name, class: 'w-12 h-12')
      h3(class: 'col-start-2 text-lg font-bold') { title }
      p(class: 'col-start-2') { description }
    end
  end
end
