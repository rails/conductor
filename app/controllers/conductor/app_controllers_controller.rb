require 'rails/generators'

module Conductor
  class AppControllersController < ApplicationController
    def new
      @page_title = 'Controllers'
    end

    def create
      @form = ControllerGeneratorForm.new(params[:app_controller])

      if @form.valid?
        Rails.logger.info @form.command_line
        @form.run
        flash[:success] = "The controller was created!"
      else
        flash[:error] = "Cannot create the controller! Please verify the information"
      end

      redirect_to(new_app_controller_url)
    end
    
  end
end
