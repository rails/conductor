require_dependency "conductor/application_controller"

module Conductor
  class MigrationsController < ApplicationController
    def index
      @migrations = Migrations.list
    end

    def up
      begin
        Migrations.to_version(:up, params[:id])
        flash[:success] = "Migrated up"
      rescue Migrations::MigrationError => e
        flash[:error] = e.message
      end

      redirect_to migrations_path
    end

    def down
      begin
        Migrations.to_version(:down, params[:id])
        flash[:success] = "Migrated down"
      rescue Migrations::MigrationError => e
        flash[:error] = e.message
      end

      redirect_to migrations_path
    end

  end
end
