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
      @content=nil
      unless env['rack.hijack?']
        spawn("> log/command.log")
        redirect_to output_no_websocket_database_path
      end
    end

    def output_no_websocket
      spawn(session[:conductor_command_db] + "> log/command.log")
      @content = File.read(File.join(Rails.root,'log','command.log'))
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
      begin
        open_socket(session[:conductor_command_db] || "bundle exec rake db:version")
      rescue Tubesock::HijackNotAvailable
        puts "Websocket not available for this webserver"
        redirect_to output_no_websocket_database_path
      end
    end

    def create
      session[:conductor_command_db] = "bundle exec rake db:create"
      redirect_to output_database_path
    end

  end
end
