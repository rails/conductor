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

  def documentation_rails
    if File.exist?(File.join(Rails.root, 'doc', 'api','index.html'))
      #link_to("Rails API", "file://#{File.join(Rails.root,'doc','api','index.html')}", target: "_blank" )
      link_to_doc('Rails API','api')
    else
      link_to("Rails API", "http://api.rubyonrails.org/",target: "_blank")
    end
  end

def link_to_doc(text, folder)
  url = File.join(main_app.root_url, 'doc', folder, 'index.html')
  %Q(<a href="#{url}">#{text}</a>).html_safe
end

end
