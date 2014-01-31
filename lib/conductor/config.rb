require 'active_support/configurable'

module Conductor
  include ActiveSupport::Configurable
  config_accessor :enable_editor, :enable_scenario_recorder

  def self.configure(&block)
    yield self
  end

  configure do |config|
    config.enable_editor = true
    config.enable_scenario_recorder = true
  end
end
