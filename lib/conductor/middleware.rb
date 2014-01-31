require 'conductor/middleware_util'

module Conductor
  class Middleware
    include MiddlewareUtil

    def initialize(app)
      @app = app
    end

    def call(env)
      @app.call(env).tap do |status, headers, body|
        if body.is_a?(ActionDispatch::Response)
          if (body.request.path !~ %r[^/*conductor/])
            container_div = %Q[<div id="#{Conductor::CONTAINER}" style="position:absolute; top:0; right: 0;"><link href="/assets/conductor/recorder.css" media="all" rel="stylesheet" type="text/css"></div>]
            body.body = insert_text body.body, :before, /<\/body>/i, container_div
          end

          if body.request.format.html? && Thread.current[Conductor::VIEW_FILENAME]
            editor_container = %Q[#{edit_link}#{partials}]
            body.body = insert_text body.body, :after, /<div id="#{Conductor::CONTAINER}" .*?>/i, editor_container
            Thread.current[Conductor::VIEW_FILENAME] = nil
          end
          if body.request.format.html? && (body.request.path !~ %r[^/*conductor/])
            body.body = insert_text body.body, :before, /<\/head>/i, %Q[<script src="assets/recorder.js"></script>]
            body.body = insert_text body.body, :after, /<div id="#{Conductor::CONTAINER}" .*?>/i, %Q[#{spec_link}#{spec}]
          end
        end
      end
    end

  private
    def edit_link
      %Q[<a href="/conductor/editor?template=#{Thread.current[Conductor::VIEW_FILENAME]}" data-remote="true" onclick="$(this).closest('div').find('div.partials').toggle()" class="edit">edit</a>]
    end

    def partials
      %Q[<div class="partials" style="display:none">#{(Thread.current[Conductor::PARTIAL_FILENAMES] || []).map(&:virtual_path).map {|v| '<a href="/conductor/editor?template=' + v + '" data-remote="true" class="partials">' + v + '</a>'}.join('')}</div>]
    end
     def spec_link
      %Q[<a href="/conductor/recorder" data-remote="true" class="spec">spec</a>]
    end

    def spec
      #FIXME more assertions
      %Q[<div class="spec" style="display:none"><div align="right"><a href="/conductor/recorder" data-remote="true" data-method="delete" class="clear">Clear</a></div></div>]
    end
  end
end
