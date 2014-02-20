require_dependency "conductor/application_controller"

module Conductor
  class CodesController < ApplicationController
    before_action :set_path

    def index
      @files = Conductor::Code.find_by_path(@path)
    end

    def edit
      @code = Conductor::Code.new(@path)
    end

    def update
      @code = Conductor::Code.new(@path)
      @code.content = params[:code][:content]
      @code.save
      flash[:success] = "The File was successfully updated!"
      redirect_to edit_code_path(@path)
    end

    def create
      @code = Conductor::Code.new(params[:code][:path] + "/" + params[:code][:name])
      @code.save
      redirect_to edit_code_path(@path)
    end

    private

      def set_path
        @path = params[:path] || Rails.root
      end

  end
end
