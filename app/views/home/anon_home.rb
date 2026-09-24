class Views::Home::AnonHome < Views::Base
  include Phlex::Rails::Helpers::ImageTag

  FEATURES = [
    { icon: 'sticker-check-outline', title: 'get_your_name_right', blurb: 'name_right_blurb' },
    { icon: 'bullhorn', title: 'pronunciation', blurb: 'pronunciation_blurb' },
    { icon: 'gender-male-female', title: 'pronouns', blurb: 'pronouns_blurb' }
  ].freeze

  def view_template
    hero
    features
    sign_up
  end

  private

  def hero
    section(class: 'px-4 py-12 text-center') do
      h1(class: 'inline-grid grid-cols-[1.15em_auto_auto] gap-px text-5xl leading-none font-bold whitespace-nowrap') { wordmark }
      h2(class: 'mt-6 text-[2rem] text-primary') { t('.subtitle') }
    end
  end

  def wordmark
    image_tag('logo.svg', alt: t('icon_alt'), class: 'h-[1em] pr-[0.15em]')
    span(class: 'text-right') { t('.title.namedot') }
    span(class: 'text-left') { t('.title.pn') }
    span(class: 'col-start-3 pl-0.5 text-left text-xl text-primary') do
      plain t('.title.pronouns')
      br
      plain t('.title.pronounce')
    end
  end

  def features
    Container do
      div(class: 'grid gap-6 md:grid-cols-3') do
        FEATURES.each { feature(**it) }
      end
    end
  end

  def feature(icon:, title:, blurb:)
    Card do
      div(class: 'card-body flex-row gap-4') do
        Icon(icon, class: 'size-12 shrink-0 fill-current')
        div do
          h3(class: 'card-title') { t(".#{title}") }
          p(class: 'mt-4') { t(".#{blurb}") }
        end
      end
    end
  end

  def sign_up
    Container(class: 'space-y-5 text-center') do
      p { Button(href: new_user_registration_path, variant: :secondary, size: :xl) { t('.sign_up_free') } }
      p(class: 'text-muted') { t('.warning') }
      p { Link(page_path('about')) { t('.learn_more') } }
    end
  end
end
