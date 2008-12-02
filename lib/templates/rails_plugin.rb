module Groff
  class Template < ActionView::TemplateHandler
 
    def render(template, local_assigns = {})
      #keep ie happy
      if @view.controller.request.env['HTTP_USER_AGENT'] =~ /msie/i
        @view.controller.headers['Pragma'] ||= ''
        @view.controller.headers['Cache-Control'] ||= ''
      else
        @view.controller.headers['Pragma'] ||= 'no-cache'
        @view.controller.headers['Cache-Control'] ||= 'no-cache, must-revalidate'
      end

      @view.controller.headers["Content-Disposition"] ||= "#{ @attach ? "attachment" : "inline" }; filename=\"#{@filename || @view.controller.controller_name}\""
      
      #TODO: Detect the format, to use pdf or ps
      Document.new(template.source, :binding => @view.send(:binding) ).to_pdf
    end
 
    def cache_fragment(block, name = {}, options = nil)
    end
  end
end
 
 
 
 
Mime::Type.register "application/pdf", :pdf                
Mime::Type.register "application/postscript", :ps
if defined? ActionView::Template and ActionView::Template.respond_to? :register_template_handler
  ActionView::Template
else
  ActionView::Base
end.register_template_handler(:groff, Groff::Template)