require_dependency "conductor/application_controller"
require 'pty'
include Tubesock::Hijack
module Conductor
  class TestsController < ApplicationController
  	def show 
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
      open_socket(session[:conductor_command_test] || "rake test")
    end
  end
end
