require_dependency "conductor/application_controller"

module Conductor
  class TestsController < ApplicationController
  	def show
  		@tests  = File.read("tmp/test.log") 
  	end

  	def run
  		spawn("rake test > tmp/test.log")
  		redirect_to test_path
  	end
  end
end
