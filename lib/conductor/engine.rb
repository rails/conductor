require "jquery/rails/engine"
require "rails/all"
require "conductor/middleware"

module Conductor
  class Engine < Rails::Engine
    isolate_namespace Conductor

    initializer 'asset_pipeline' do |app|
      app.config.assets.precompile += ['conductor.js', 'conductor.css', 'conductor/gemfile.js', 'conductor/editor.js']
    end

    config.autoload_paths << File.expand_path("../app/forms", __FILE__)

    config.after_initialize do |app|
      app.routes.prepend do
        mount Conductor::Engine => '/conductor'
      end
    end

    initializer 'serve_docs' do |app|
      app.config.middleware.use Rack::Static, :urls => ["/doc"]
    end

    initializer 'load_generators' do |app|
      app.load_generators
    end

    initializer 'conductor.add middleware' do |app|
      app.middleware.use Conductor::Middleware
    end

    ActiveSupport.on_load(:action_view) do
      if Conductor.config.enable_editor
        module ::ActionView
          class PartialRenderer
            def render_partial_with_filename_caching
              (Thread.current[Conductor::PARTIAL_FILENAMES] ||= []) << @template unless @view.controller.class.name.starts_with?('Conductor::')
              render_partial_without_filename_caching
            end
            alias_method_chain :render_partial, :filename_caching
          end

          class TemplateRenderer
            def render_template_with_filename_caching(template, layout_name = nil, locals = {})
              Thread.current[Conductor::VIEW_FILENAME] = template.virtual_path if @view.controller.try(:request).try(:format).try(:html?) && !@view.controller.class.name.starts_with?('Conductor::')
              render_template_without_filename_caching template, layout_name, locals
            end
            alias_method_chain :render_template, :filename_caching
          end
        end
      end
    end
  end
end
