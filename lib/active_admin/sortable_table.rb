require 'activeadmin'
require 'active_admin/sortable_table/handle_column'

# Slimmed from no-longer-maintained https://github.com/bolshakov/activeadmin_sortable_table/blob/master/lib/active_admin/sortable_table.rb (MIT license)
module ActiveAdmin
  module SortableTable
    class <<self
      def included(dsl)
        dsl.instance_eval do
          member_action :sort, method: :post do
            resource.insert_at params[:position].to_i
            head 200
          end
        end
      end
    end
  end
end
