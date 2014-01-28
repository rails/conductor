require 'active_support/configurable'

module Conductor
  include ActiveSupport::Configurable
  config_accessor :enable_editor

  def self.configure(&block)
    yield self
  end

  configure do |config|
    config.enable_editor = true
  end
end
