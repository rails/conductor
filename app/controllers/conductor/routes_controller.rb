require 'action_dispatch/routing/inspector'
module Conductor
  class RoutesController < ApplicationController
    prepend_view_path ActionDispatch::DebugExceptions::RESCUES_TEMPLATE_PATH

    def index
      all_routes = Rails.application.routes.routes
      @routes_inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)
    end
  end
end
