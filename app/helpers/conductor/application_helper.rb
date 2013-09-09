# Methods added to this helper will be available to all templates in the application.
module Conductor::ApplicationHelper

  def tolk_link
    if defined?(Tolk)
      link_to("Tolk", '/tolk') 
    else
      link_to("Tolk", "http://www.github.com/tolk/tolk",target: "_blank",confirm:"This extension is not installed." ) 
    end        
  end

  def webconsole_link
    if defined?(WebConsole)
      link_to("WebConsole", '/console') 
    else
      link_to("WebConsole", "https://github.com/rails/web-console",target: "_blank",confirm:"This extension is not installed." ) 
    end        
  end

end
