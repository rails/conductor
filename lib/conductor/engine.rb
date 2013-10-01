require "jquery/rails/engine"
require "rails/all"

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
  end
end
