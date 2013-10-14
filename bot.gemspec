# -*- encoding: utf-8 -*-
require File.expand_path('../lib/bot/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Todd Lunter"]
  gem.email         = %w{tlunter@gmail.com}
  gem.description   = %q{}
  gem.summary       = %q{}
  gem.homepage      = 'https://github.com/tlunter/bot'
  gem.license       = 'MIT'
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "bot"
  gem.require_paths = %w{lib}
  gem.version       = Bot::VERSION
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'cane'
  gem.add_development_dependency 'pry'
end
