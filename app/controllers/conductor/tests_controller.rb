require_dependency "conductor/application_controller"
include Tubesock::Hijack
module Conductor
  class TestsController < ApplicationController
  	def show
      @content=nil
      unless env['rack.hijack?']
        spawn("> log/command.log")
        redirect_to show_no_websocket_test_path
      end
    end

  	def run_all
      session[:conductor_command_test] = "rake test"
      redirect_to test_path
  	end

    def run_model
      session[:conductor_command_test] = "rake test:models"
      redirect_to test_path
    end

    def run_controller
      session[:conductor_command_test] = "rake test:controllers"
      redirect_to test_path
    end

    def run_integration
      session[:conductor_command_test] = "rake test:integration"
      redirect_to test_path
    end

    def websocket_test
      begin
        open_socket(session[:conductor_command_test] || "rake test")
      rescue Tubesock::HijackNotAvailable
        redirect_to show_no_websocket_test_path
      end
    end

    def show_no_websocket
      spawn(session[:conductor_command_test] + "> log/command.log")
      @content = File.read(File.join(Rails.root,'log','command.log'))
    end
  end
end
