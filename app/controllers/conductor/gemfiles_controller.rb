require_dependency "conductor/application_controller"
include Tubesock::Hijack
require 'pty'
module Conductor
  class GemfilesController < ApplicationController

    def install
    end

    def check_install
      open_socket('bundle install')
    end

  end
end
