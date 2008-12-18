require 'test/unit'
require 'tempfile'
require 'groff'

module Groff
  class GroffTempfile < Tempfile
    def initialize
      super("groof_test")
    end
    def type
      %x(`env which file` -b #{self.path})
    end
  end

  class GroffTest < Test::Unit::TestCase
    include Groff
    def setup
      @file = GroffTempfile.new
    end
    
    def read_fixture(name = "sample_docs")
      File.read( File.join( File.dirname(__FILE__), "fixtures" , name + ".mom") )
    end
    
    def test_true 
      assert true
    end
  
    def test_to_ps
      @file.write Document.new(read_fixture).to_ps
      @file.close
      assert_match /PostScript/i, @file.type
    end
    
    def test_to_pdf
      @file.write Document.new(read_fixture).to_pdf
      @file.close
      assert_match /PDF/i, @file.type      
    end
    
    def test_erb
      doc = Document.new(read_fixture("erb"), :binding => binding)
      doc.send :filter_erb
      out = doc.instance_variable_get :@output
      assert_match /#{%x(hostname).strip.split(".").first}/, out
      assert_match /#{time_now.strftime "%A, %d %b %Y %H:%M"}/, out
    end

    def test_utf8_to_iso_translation
      doc = Document.new(read_fixture("utf8"))
      assert_nothing_raised do
        doc.to_ps
      end
    end

    def time_now
      @time_now ||= Time.now
    end
  end
end
