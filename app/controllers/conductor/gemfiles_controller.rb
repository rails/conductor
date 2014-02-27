require_dependency "conductor/application_controller"
include Tubesock::Hijack
module Conductor
  class GemfilesController < ApplicationController
    def install
      @content=nil
      unless env['rack.hijack?']
        spawn("> log/commandgem.log")
        redirect_to install_no_websocket_gemfile_path
      end
    end

    def check_install
      begin
        open_socket('bundle install')
      rescue Tubesock::HijackNotAvailable
        puts "Websocket not available for this webserver"
        redirect_to install_no_websocket_gemfile_path
      end
    end
    def install_no_websocket
      spawn("bundle install > log/commandgem.log")
      @content = File.read(File.join(Rails.root,'log','commandgem.log'))
    end


  end
end
