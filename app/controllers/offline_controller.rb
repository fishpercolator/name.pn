class OfflineController < ApplicationController
  skip_after_action :verify_authorized

  layout -> { Views::Layouts::Offline }

  def show
  end
end
