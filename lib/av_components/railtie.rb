require 'rails/railtie'

module AvComponents
  class Railtie < ::Rails::Railtie
    initializer "av_components.action_view" do |app|
      ActiveSupport.on_load :action_view do
        require "av_components/vue_helper"

        include AvComponents::VueHelper
      end
    end
  end
end
