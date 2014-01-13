module Conductor
  class ApplicationController < ActionController::Base
    before_filter :ensure_local_request
    before_filter :set_page_title

    private
      def ensure_local_request
        unless local_request?
          render :text => "Only available from localhost", :status => :forbidden
        end
      end

      def set_page_title
        @page_title = self.class.controller_name.capitalize
      end

      def local_request?
        request.remote_addr == '127.0.0.1'
      end

      def open_socket(command)
        hijack do |tubesock|
          tubesock.onopen do
            begin
              PTY.spawn( command) do |stdin, stdout, pid|
                begin
                  stdin.each do |line| 
                    tubesock.send_data line
                    sleep 2
                  end
                rescue Errno::EIO
                  puts "Errno:EIO error, but this probably just means " +
                    "that the process has finished giving output"
                end
              end
            rescue PTY::ChildExited
              puts "The child process exited!"
            end 
          end
        end
      end 
  end
end