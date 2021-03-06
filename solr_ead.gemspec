# -*- encoding: utf-8 -*-
require File.expand_path('../lib/solr_ead/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Adam Wead"]
  gem.email         = ["amsterdamos@gmail.com"]
  gem.description   = %q{A gem for indexing ead into solr using OM. Define your own OM terminology to create the solr fields you want from your ead, then use solr-based applications like Blacklight to search and display the results.}
  gem.summary       = %q{A gem for indexing ead into solr using OM}
  gem.homepage      = "http://github.com/awead/solr_ead"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "solr_ead"
  gem.require_paths = ["lib"]
  gem.version       = SolrEad::VERSION

  # Dependencies
  gem.add_dependency('om')
  gem.add_dependency('solrizer', '~> 2.1.0')
  gem.add_dependency('rsolr')
  gem.add_dependency('sanitize')
  gem.add_development_dependency('yard')
  gem.add_development_dependency('redcarpet')
  # For Development
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'debugger'
  gem.add_development_dependency 'rdoc'
end
