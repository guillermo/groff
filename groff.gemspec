# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{groff}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Guillermo \303\201lvarez"]
  s.date = %q{2008-12-18}
  s.description = %q{Groff Parser and template engine for rails}
  s.email = %q{guillermo@cientifio.net}
  s.extra_rdoc_files = ["CHANGELOG", "lib/document.rb", "lib/groff.rb", "lib/templates/rails_plugin.rb", "README.rdoc"]
  s.files = ["CHANGELOG", "groff.gemspec", "init.rb", "lib/document.rb", "lib/groff.rb", "lib/templates/rails_plugin.rb", "Manifest", "Rakefile", "README.rdoc", "test/fixtures/erb.mom", "test/fixtures/letter.mom", "test/fixtures/penguin.ps", "test/fixtures/sample_docs.mom", "test/fixtures/typesetting.mom", "test/fixtures/utf8.mom", "test/test_groff.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/guillermo/groff}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Groff", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{groff}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Groff Parser and template engine for rails}
  s.test_files = ["test/test_groff.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
