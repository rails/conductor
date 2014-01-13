require_dependency "conductor/application_controller"
include Tubesock::Hijack
  require 'pty'
module Conductor
  class GemfilesController < ApplicationController

    def show
      @gemfile = Gemfile.instance
    end

    def update
      @gemfile = Gemfile.instance
      @gemfile.content = params[:gemfile][:content]
      @gemfile.save
      flash[:success] = "The gemfile was successfully updated!"
      redirect_to gemfile_path
    end

    def install
    end

    def check_install
      open_socket('bundle install')
    end

  end
end
