module ActiveAdmin
  module SortableTable
    module HandleColumn
      def handle_column
        column '' do |resource|
          content_tag(:span, '&#9776;'.html_safe, class: 'sortable-handle',
            data: {
              sort_url: url_for([:sort, :admin, resource]),
              position: resource.public_send(resource.position_column)
            }
          )
        end
      end
      def handle_column_js
        script <<~JS.html_safe
          const csrfToken = document.getElementsByName('csrf-token')[0].content
          document.querySelectorAll('.sortable-handle').forEach(handle => {
            let tr = handle.closest('tr')
            tr.draggable = true
            tr.classList.add('bg-white')
            tr.addEventListener('dragstart', e => e.dataTransfer.setData("sortUrl", handle.dataset.sortUrl))
            tr.addEventListener('dragover', e => {
              e.preventDefault()
              tr.classList.replace('bg-white', 'bg-gray-100')
            })
            tr.addEventListener('dragleave', e => tr.classList.replace('bg-gray-100', 'bg-white'))
            tr.addEventListener('drop', async e => {
              e.preventDefault()
              const url = e.dataTransfer.getData("sortUrl")
              const position = handle.dataset.position
              await fetch(url, {
                method: "POST",
                body: JSON.stringify({ position }),
                headers: {
                  "X-CSRF-Token": csrfToken,
                  "Content-Type": "application/json"
                }
              })
              location.reload()
            })
          })
        JS
      end
    end
    ::ActiveAdmin::Views::TableFor.include(HandleColumn)
  end
end
