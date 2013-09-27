require 'rails/generators'

module Conductor
  class MailersController < ApplicationController
    def new

    end

    def create
      @form = MailerGeneratorForm.new(params[:mailer])

      if @form.valid?
        Rails.logger.info @form.command_line
        @form.run
        flash[:success] = "The mailer was created!"
      else
        flash[:error] = "Cannot create the mailer! Please verify the information"
      end

      redirect_to(new_mailer_url)
    end
    
  end
end
