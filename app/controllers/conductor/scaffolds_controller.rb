require 'rails/generators'

module Conductor
  class ScaffoldsController < ApplicationController
    def new
    end

    def create
      @form = ScaffoldGeneratorForm.new(params[:scaffold])

      if @form.valid?
        Rails.logger.info @form.command_line
        @form.run
        flash[:success] = "The scaffold was created!"
      else
        flash[:error] = "Cannot create the scaffold! Please verify the information"
      end

      redirect_to(new_scaffold_url)
    end
  end
end
