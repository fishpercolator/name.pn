class Views::Layouts::Offline < Views::Base
  include Phlex::Rails::Layout

  def view_template(&)
    doctype
    html(lang: "en") do
      head do
        display_meta_tags
        style { stylesheet }
      end
      body { main(&) }
    end
  end

  private

  def stylesheet = <<~CSS
    body {
      background: #{Rails.configuration.x.pwa.background_color};
      color: #1b292b;
      display: grid;
      font-family: Raleway, ui-sans-serif, system-ui, sans-serif;
      margin: 0;
      min-height: 100dvh;
      place-items: center;
    }

    main {
      display: grid;
      gap: 1rem;
      padding: 2rem;
      place-items: center;
      text-align: center;
    }

    main svg {
      height: auto;
      width: 5rem;
    }

    main p {
      max-width: 30rem;
    }
  CSS
end
