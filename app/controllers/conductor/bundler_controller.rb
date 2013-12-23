require_dependency "conductor/application_controller"

module Conductor
  class BundlerController < ApplicationController
  	def show
      spawn("bundle install > tmp/bundler.log")
  		@bundler = File.read("tmp/bundler.log") 
  	end
  end
end
