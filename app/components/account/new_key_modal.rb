class Components::Account::NewKeyModal < Components::Base
  def initialize(key)
    @key = key
  end

  def view_template
    Modal(t('.title'), open: true, class: 'api-key-modal') do
      p(class: 'my-4') { t('.blurb') }
      code(class: 'api-key block rounded-box bg-base-200 p-4 font-mono text-xl break-all') { @key }
    end
  end
end
