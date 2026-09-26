class Components::Shared::Analytics < Components::Base
  def initialize(tracking_id:, user_id: nil)
    @tracking_id = tracking_id
    @user_id = user_id
  end

  def render? = @tracking_id.present?

  def view_template
    script(async: true, src: "https://www.googletagmanager.com/gtag/js?id=#{@tracking_id}")
    script { raw safe(setup) }
    script(type: 'module') { raw safe(track_turbo_visits) }
  end

  private

  def visitor = { user_id: @user_id }.compact

  def setup
    <<~JS
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      gtag('config', #{@tracking_id.to_json});
    JS
  end

  def track_turbo_visits
    <<~JS
      let isInitialLoad = true;
      document.addEventListener('turbo:load', (e) => {
        if (isInitialLoad) { isInitialLoad = false; return; }
        gtag('config', #{@tracking_id.to_json}, { ...#{visitor.to_json}, page_location: e.detail.url });
      });
    JS
  end
end
