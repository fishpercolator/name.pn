# frozen_string_literal: true

class Views::Pages::About < Views::Base
  def view_template
    Prose do <<~MD
      # About name.pn

      Like most useful products, name.pn was born out of necessity. Developer **Quinn** [name.pn/quinn-daley](https://name.pn/quinn-daley) is trans & non-binary and uses they/them pronouns and needed a nice way to share how to use those pronouns with business contacts.

      These days we do a lot of our communicating electronically. We can see a person's name a dozen times and

      * never learn how to **pronounce** it the way they want it to be pronounced,
      * not know what **pronouns** to use when talking about them in the third person,
      * want to **address them formally** but not know what title to use (or even if they want to be addressed by a title),
      * hear them being called by a shortened version of their name and not know **if they actually like it**.
      
      name.pn was created to give each person a **short URL** that you can put in your email signature and your social profiles that gives people all the information they need to address you correctly, including a chance to hear you pronouncing your name in your own voice.

      It's free and always will be (although we might add some cool additional paid features in the future for businesses). It's still early in development but it works and it's ready to use now.
    MD
    end
    div(class: 'py-5') do
      cta(new_user_registration_path, variant: :primary) do
        'Sign up for your free name.pn page'
      end
    end
    Prose do <<~MD
    ## Working in the open

    name.pn is an open source product and we are working in the open.

    We welcome contributions to our roadmap, including bug reports, feature requests and even code changes! Follow the links below for more information.
    MD
    end
    div(class: 'py-5') do
      cta('https://github.com/fishpercolator/name.pn/issues', icon_name: 'bug') do
        'Report a bug or make a feature request'
      end
      cta('https://github.com/orgs/fishpercolator/projects/1', icon_name: 'map') do
        "See what's coming up next on our roadmap"
      end
      cta('https://github.com/fishpercolator/name.pn/blob/main/CONTRIBUTING.md', icon_name: 'wrench-outline') do
        'Read about how you can contribute to name.pn'
      end
      cta('https://github.com/fishpercolator/name.pn', icon_name: 'github') do
        'Browse our source code on GitHub'
      end
    end
    Prose do <<~MD
    ## Get in touch

    If you'd like to report an issue or feature request, please use [our issues board](https://github.com/fishpercolator/name.pn/issues). But to get in touch for any other reason, our email address is below.
    MD
    end
    div(class: 'py-5') do
      cta('mailto:support@name.pn', icon_name: 'email') do
        'support@name.pn'
      end
    end
  end

  private

  def cta(href, icon_name: nil, variant: :outline, &)
    div(class: 'mb-2') do
      Link(href:, variant:) do
        icon(icon_name, class: 'w-4 h-4 -ml-1 mr-2 fill-current') if icon_name
        span(&)
      end
    end
  end

end
