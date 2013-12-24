require_dependency "conductor/application_controller"
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
      file = File.new("tmp/bundler.log", "w")   
      file.puts " "  
      file.close 
      begin
      PTY.spawn( "bundle install") do |stdin, stdout, pid|
      begin
        stdin.each { |line| print line 
          open('tmp/bundler.log', 'a') { |f| f.puts line}
        }
          rescue Errno::EIO
          puts "Errno:EIO error, but this probably just means " +
            "that the process has finished giving output"
        end
      end
      rescue PTY::ChildExited
      puts "The child process exited!"
      end
      @install = File.read("tmp/bundler.log") 
    end
  end
end
