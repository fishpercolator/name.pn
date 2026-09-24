class PagesController < ApplicationController
  include HighVoltage::StaticPage

  layout -> { Views::Layouts::Page }
end
