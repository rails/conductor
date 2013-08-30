# Methods added to this helper will be available to all templates in the application.
module Conductor::ApplicationHelper

  def tolk_link
    if defined?(Tolk)
      link_to("Tolk", '/tolk') 
    else
      'Tolk'
    end        
  end
end
