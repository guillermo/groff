module Groff
  class Document
    
    # Initialize the document
    # Document.new(roff_text, )
    def initialize(text, options = {})
      raise ArgumentError, "Expected text to render with groff" unless text.kind_of? String
      @options = Hash.new
      @options[:params] = "-Tps -dpaper=a4l -P-pa4 -mom"
      @options[:iconv] = true
      @options.merge! options
      @body = text
    end

    # Return a postcript
    def to_ps
      filter_erb
      filter_iconv
      IO.popen( ps_command , "r+") do |groff|
        groff.write @output
        groff.close_write
        @output =  groff.read
      end
    end

    # Return a pdf
    def to_pdf
      filter_erb
      filter_iconv
      IO.popen( pdf_command , "r+") do |groff|
        groff.write @output
        groff.close_write
        @output =  groff.read
      end
    end 
    
  private
    def filter_iconv
      @output = Iconv.iconv("iso-8859-15","utf-8", @output)
    rescue Iconv::IllegalSequence
      @output = Iconv.iconv("iso-8859-1","utf-8", @output)
    end
    
    def filter_erb
      @output = ::ERB.new(@body,nil,"%").result(@options[:binding]) 
    end
    
    def pdf_command
      "groff #{@options[:params]} | ps2pdf14 -"
    end
    
    def ps_command
      "groff #{@options[:params]} "
    end
  end
end