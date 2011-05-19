require 'rubygems'
require 'action_dispatch/middleware/show_exceptions'

module ActionDispatch
  class ShowExceptions
    def rescue_action_locally(request, exception)
      template = ActionView::Base.new([File.join(File.dirname(__FILE__), 'templates')],
        :request => request,
        :exception => exception,
        :application_trace => application_trace(exception),
        :framework_trace => framework_trace(exception),
        :full_trace => full_trace(exception)
        )
      file = "rescues/#{@@rescue_templates[exception.class.name]}.erb"
      body = template.render(:file => file, :layout => 'rescues/layout.erb')
      render(status_code(exception), body)
    end
  end
end 

module LinkifyErrors
  PROTOCOL = "editfile"
  
  def self.linkify(str)
    file, line, desc = str.split(':')
    
    if file[0..0] == "/"
      # we already have an absolute path. We're good!
    elsif file =~ /(.*) \((.*)\) (.*)/
      # This is a part-of-rails gem, e.g. "actionpack (3.1.0.beta1) lib/action_controller/....."
      gemspecs = Gem.source_index.find_name($1)
      version_in_use = gemspecs.find {|gemspec| gemspec.version.to_s == $2 }
      base_path = version_in_use.rg_full_gem_path
      file = "#{base_path}/#{$3}"
    else 
      # This is an app-local file, and just needs to be joined to Rails.root
      file = Rails.root + file
    end

    url = "#{PROTOCOL}://#{line}@#{file}"

    "<a href='#{url}'>#{str}</a>".html_safe
  end
end
