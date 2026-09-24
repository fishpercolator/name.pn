class Components::Clients::Table < Components::Base
  include Phlex::Rails::Helpers::TimeAgoInWords

  NAME_HEADING = 'client-name-th'.freeze

  def initialize(clients, new_client)
    @clients = clients
    @new_client = new_client
  end

  def view_template
    Table do
      thead { headings }
      tbody do
        @clients.each { client_row(it) }
        new_client_row
      end
    end
  end

  private

  def headings
    tr do
      th(id: NAME_HEADING) { Client.human_attribute_name(:name) }
      th { Client.human_attribute_name(:created_at) }
      th
    end
  end

  def client_row(client)
    tr(class: 'api-client') do
      td { client.name }
      td { t('ago', time: time_ago_in_words(client.created_at)) }
      td { delete_button(client) }
    end
  end

  def delete_button(client)
    Button(href: client_path(client), method: :delete, variant: :danger, size: :sm, icon: 'delete', form: { data: { turbo_confirm: t('.confirm_delete') } }) do
      t('actions.delete')
    end
  end

  def new_client_row
    tr(class: 'new-api-key') do
      td { new_client_form }
      td { Button(type: :submit, form: 'new_client', variant: :success, icon: 'plus') { t('.create') } }
      td
    end
  end

  def new_client_form
    Form(model: @new_client, id: 'new_client') do |form|
      form.input :name, required: true, placeholder: t('.placeholder'), aria: { labelledby: NAME_HEADING }
    end
  end
end
