class Components::Account::ApiKeys < Components::Base
  include Phlex::Rails::Helpers::TimeAgoInWords

  def initialize(clients, new_client)
    @clients = clients
    @new_client = new_client
  end

  def view_template
    Table(headings: [Client.human_attribute_name(:name), Client.human_attribute_name(:created_at), nil]) do |table|
      @clients.each do |client|
        table.row(class: 'api-client') do
          table.cell { client.name }
          table.cell { t('ago', time: time_ago_in_words(client.created_at)) }
          table.cell { delete_button(client) }
        end
      end
      table.row(class: 'new-api-key') do
        table.cell { new_key_form }
        table.cell { create_button }
        table.cell
      end
    end
  end

  private

  def delete_button(client)
    Button(href: client_path(client), method: :delete, variant: :danger, size: :sm, icon: 'delete', form: { data: { turbo_confirm: t('.confirm_delete') } }) do
      t('actions.delete')
    end
  end

  def new_key_form
    Form(model: @new_client, id: 'new_client') do |form|
      form.input :name, required: true, aria: { label: Client.human_attribute_name(:name) }
    end
  end

  def create_button
    Button(type: :submit, form: 'new_client', variant: :success, icon: 'plus') { t('.create') }
  end
end
