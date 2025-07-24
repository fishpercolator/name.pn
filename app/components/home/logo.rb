# frozen_string_literal: true

class Components::Home::Logo < Components::Base
  def view_template
    div(class: 'flex flex-col items-center gap-4') do
      h1(class: 'text-5xl font-bold leading-none grid grid-cols-[1.15em_1fr_1fr] grid-rows-2') do
        div(class: 'pr-[0.15em]') { image_tag 'logo.svg', alt: t('icon_alt') }
        div(class: 'text-right') { t('.namedot') }
        div { t('.pn') }
        div(class: 'text-xl leading-none text-accent mt-2 pl-[2px] col-start-3 flex flex-col') do
          span { t('.pronouns') }
          span { t('.pronounce') }
        end
      end
      h2(class: 'text-2xl md:text-4xl text-accent') { t('.subtitle') }
    end
  end
end
