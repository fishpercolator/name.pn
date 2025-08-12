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
      render Home::Card::Url.new
      div(class: 'flex flex-col gap-3 *:flex-auto') do
        render Home::Card::Name.new
        render Home::Card::Pronouns.new
        render Home::Card::Pronunciation.new
      end
      div(class: 'flex flex-col gap-3 *:flex-auto') do
        render Home::Card::Variants.new
        render Home::Card::Likeness.new
        render Home::Card::Links.new
      end
    end
  end

  def pronunciation_card
    
  end

  def links_card
  end

end
