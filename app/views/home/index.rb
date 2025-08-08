# frozen_string_literal: true

class Views::Home::Index < Views::Base
  include Phlex::Rails::Helpers::ContentTag

  def view_template
    page_title = title(t '.title')

    ShellLayout do
      PageIntro(
        title: page_title, 
        paragraphs: [t('.page_description1'), t('.page_description2')]
      )
      profile_grid
    end
  end

  protected

  def profile_grid
    section(class: 'grid grid-cols-1 md:grid-cols-2 gap-3') do
      url_card
      div(class: 'flex flex-col gap-3 *:flex-auto') do
        name_card
        pronouns_card
        pronunciation_card
      end
      div(class: 'flex flex-col gap-3 *:flex-auto') do
        variants_card
        likeness_card
        links_card
      end
    end
  end

  def url_card
    render Home::Card.new(title: t('.url_card.title'), edit: profile_path(:slug), class: 'md:col-span-2 bg-indigo-50 dark:bg-indigo-950') do
    end
  end

  def name_card
    render Home::Card.new(title: t('.name_card.title'), edit: profile_path(:personal_name), class: 'bg-rose-50 dark:bg-rose-950') do |hc|
      hc.content do
        hc.blurb { t('profile.personal_name.blurb') }
        hc.list(user_attributes_hash %i[personal_name full_name])
      end
    end
  end

  def pronouns_card
    render Home::Card.new(title: t('.pronouns_card.title'), edit: profile_path(:pronouns), class: 'bg-green-50 dark:bg-green-950')
  end

  def pronunciation_card
    render Home::Card.new(title: t('.pronunciation_card.title'), edit: profile_path(:pronunciation), class: 'bg-rose-50 dark:bg-rose-950')
  end

  def variants_card
    render Home::Card.new(title: t('.variants_card.title'), edit: profile_path(:variants), class: 'bg-green-50 dark:bg-green-950') do |hc|
      hc.content do
        hc.blurb { t('profile.variants.blurb') }
        attributes = user_attributes_hash %i[envelope_name formal_name email_name]
        hc.list(attributes.merge(human_alternate_names))
      end
    end
  end

  def likeness_card
    render Home::Card.new(title: t('.likeness_card.title'), edit: profile_path(:likeness), class: 'bg-indigo-50 dark:bg-indigo-950')
  end

  def links_card
    render Home::Card.new(title: t('.links_card.title'), edit: profile_path(:links), class: 'bg-rose-50 dark:bg-rose-950')
  end

  # Convert a list of attribute names to a hash of human name to value
  def user_attributes_hash(attributes)
    attributes.to_h { [
      User.human_attribute_name(_1), 
      current_user.public_send(_1),
    ] }
  end

  # Convert current_user.alternate_names.grouped_by_category to human-readable form
  def human_alternate_names
    current_user.alternate_names.grouped_by_category.to_h do |cat,v|
      [
        t(cat, scope: 'alternate_name_categories'),
        v.map(&:name)
      ]
    end
  end

end
