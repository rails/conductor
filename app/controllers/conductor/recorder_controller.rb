module Conductor
  class RecorderController < ActionController::Base
    # XHR
    def index
      flash.keep Conductor::SPEC
    end

    # XHR
    def destroy
      flash.discard Conductor::SPEC
    end
  end
end