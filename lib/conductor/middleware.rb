require 'conductor/middleware_util'

module Conductor
  class Middleware
    include MiddlewareUtil

    def initialize(app)
      @app = app
    end

    def call(env)
      @app.call(env).tap do |status, headers, body|
        if body.is_a?(ActionDispatch::Response) && (body.request.path !~ %r[^/*conductor/])
          body.body = insert_text body.body, :before, /<\/body>/i, %Q[<div id="#{Conductor::CONTAINER}" style="position:absolute; top:0; right: 0;"><link href="/assets/recorder.css" media="all" rel="stylesheet" type="text/css"></div>]
        end
      end
    end
  end
end