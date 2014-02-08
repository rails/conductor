require_dependency "conductor/application_controller"

module Conductor
  class CodesController < ApplicationController
    def index
    @files = Conductor::Code.find_by_path(params[:path] || Rails.root)
    end

    def edit
      @code = Conductor::Code.new(params[:path])
    end

     def update
      @code = Conductor::Code.new(params[:path])
      @code.content = params[:code][:content]
      @code.save
      flash[:success] = "The fixture was successfully updated!"
      redirect_to code_path
    end
  end
end
