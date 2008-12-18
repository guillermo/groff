# -*- coding: utf-8 -*-
module Groff
  class Document
    
    # Initialize the document
    # Document.new(roff_text, options)
    # * <b>:params</b> Is used to pass params to groof command (default is <em>-Tps -dpaper=a4l -P-pa4 -mom</em>) 
    # * <b>:binding</b> to setup an ERB binding
    def initialize(text, options = {})
      raise ArgumentError, "Expected text to render with groff" unless text.kind_of? String
      @options = Hash.new
      @options[:params] = "-Tps -dpaper=a4l -P-pa4 -mom"
      @options[:iconv] = true
      @options.merge! options
      @body = text
    end

    # Return the generated postscript
    def to_ps
      filter_erb
      filter_iconv
      IO.popen( ps_command , "r+") do |groff|
        groff.write @output
        groff.close_write
        @output =  groff.read
      end
    end

    # Return the generated pdf
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
      normalize
      @output = Iconv.iconv("iso-8859-15//ignore","utf-8", @output)
    rescue Iconv::IllegalSequence => e
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

    def normalize
      @output.tr!('“”–','""-')
      @output.gsub!('º','o')
      @output.gsub!('´','`')
      @output.gsub!('ª','a')
      @output.gsub!('ŕ','r')
      @output.gsub!(/[àâãäåāă]/,    'a')
      @output.gsub!(/æ/,            'ae')
      @output.gsub!(/[ďđ]/,          'd')
      @output.gsub!(/[çćčĉċ]/,       'c')
      @output.gsub!(/[èêëēęěĕė]/,   'e')
      @output.gsub!(/ƒ/,             'f')
      @output.gsub!(/[ĝğġģ]/,        'g')
      @output.gsub!(/[ĥħ]/,          'h')
      @output.gsub!(/[ììîïīĩĭ]/,    'i')
      @output.gsub!(/[įıĳĵ]/,        'j')
      @output.gsub!(/[ķĸ]/,          'k')
      @output.gsub!(/[łľĺļŀ]/,       'l')
      @output.gsub!(/[ñńňņŉŋ]/,      'n')
      @output.gsub!(/[òôõöøōőŏŏ]/,  'o')
      @output.gsub!(/œ/,            'oe')
      @output.gsub!(/ą/,             'q')
      @output.gsub!(/[ŕřŗ]/,         'r')
      @output.gsub!(/[śšşŝș]/,       's')
      @output.gsub!(/[ťţŧț]/,        't')
      @output.gsub!(/[ùûüūůűŭũų]/,  'u')
      @output.gsub!(/ŵ/,             'w')
      @output.gsub!(/[ýÿŷ]/,         'y')
      @output.gsub!(/[žżź]/,         'z')
      @output.gsub!(/\s+/,           ' ')
      @output
    end
  end
end
