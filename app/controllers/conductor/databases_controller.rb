require_dependency "conductor/application_controller"
include Tubesock::Hijack
module Conductor
  class DatabasesController < ApplicationController
  	def show
      @database = Database.instance
    end
        
    def update
      @database = Database.instance
      @database.content = params[:database][:content]
      @database.save
      flash[:success] = "The database was successfully updated!"
      redirect_to database_path
    end
    def output
    end
   
    def drop
      session[:conductor_command_db] = "bundle exec rake db:drop"
      redirect_to output_database_path
    end

    def seed
      session[:conductor_command_db] = "bundle exec rake db:seed"
      redirect_to output_database_path
    end

    def setup
      session[:conductor_command_db] = "bundle exec rake db:setup"
      redirect_to output_database_path
    end

    def websocket_database
      open_socket(session[:conductor_command_db] || "bundle exec rake db:version")
    end

    def create
      session[:conductor_command_db] = "bundle exec rake db:create"
      redirect_to output_database_path
    end

  end
end
