require_dependency "conductor/application_controller"

module Conductor
  class TestsController < ApplicationController
  	def show
  		@tests  = File.read("tmp/test.log") 
  	end

  	def run_all
  		spawn("rake test > tmp/test.log")
  		redirect_to test_path
  	end
    
    def run_model
      spawn("rake test:models > tmp/test.log")
      redirect_to test_path
    end
    
    def run_controller
      spawn("rake test:controllers > tmp/test.log")
      redirect_to test_path
    end
    
    def run_integration
      spawn("rake test:integration > tmp/test.log")
      redirect_to test_path
    end
  end
end
