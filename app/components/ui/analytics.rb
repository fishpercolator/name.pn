class Components::UI::Analytics < Components::Base
  def render? = Figaro.env.GA_ID?

  def view_template
    script(async: true, src: "https://www.googletagmanager.com/gtag/js?id=#{tracking_id}")
    script { raw safe(setup) }
    script(type: 'module') { raw safe(track_turbo_visits) }
  end

  private

  def tracking_id = Figaro.env.GA_ID

  def visitor = user_signed_in? ? { user_id: current_user.id } : {}

  def setup
    <<~JS
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      gtag('config', #{tracking_id.to_json});
    JS
  end

  def track_turbo_visits
    <<~JS
      let isInitialLoad = true;
      document.addEventListener('turbo:load', (e) => {
        if (isInitialLoad) { isInitialLoad = false; return; }
        gtag('config', #{tracking_id.to_json}, { ...#{visitor.to_json}, page_location: e.detail.url });
      });
    JS
  end
end
