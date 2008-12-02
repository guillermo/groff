require 'iconv'
require File.dirname(__FILE__)+'/document.rb'

if defined?(Rails)         
  require File.dirname(__FILE__)+'/templates/rails_plugin.rb'
end