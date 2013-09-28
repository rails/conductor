require_dependency "conductor/application_controller"

module Conductor
  class FixturesController < ApplicationController
    def index
      @fixtures = Conductor::Fixture.all
    end

    def edit
      @fixture = Conductor::Fixture.new(params[:path])
      
    end

     def update
      @fixture = Conductor::Fixture.new(params[:path])
      @fixture.content = params[:fixture][:content]
      @fixture.save
      flash[:success] = "The fixture was successfully updated!"
      redirect_to fixtures_path
    end

  end
end
