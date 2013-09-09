# Methods added to this helper will be available to all templates in the application.
module Conductor::ApplicationHelper

  def tolk_link
    link_to_if(defined?(Tolk), "Tolk", '/tolk') do
      link_to("Tolk", "http://www.github.com/tolk/tolk",target: "_blank",confirm:"This extension is not installed." ) 
     end       
  end

  def webconsole_link
    link_to_if(defined?(WebConsole), "WebConsole", '/console') do
      link_to("WebConsole", "https://github.com/rails/web-console",target: "_blank",confirm:"This extension is not installed." ) 
    end          
  end

end
