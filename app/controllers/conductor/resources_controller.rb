require 'rails/generators'

module Conductor
  class ResourcesController < ApplicationController
    def new
    end

    def create
      @form = ResourceGeneratorForm.new(params[:resource])

      if @form.valid?
        Rails.logger.info @form.command_line
        @form.run
        flash[:success] = "The resource was created!"
      else
        flash[:error] = "Cannot create the resource! Please verify the information"
      end

      redirect_to(new_resource_url)
    end
    
  end
end
