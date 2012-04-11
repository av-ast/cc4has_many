# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cc4has_many/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alexey Astafyev"]
  gem.email         = ["av.astafyev@gmail.com"]
  gem.description   = %q{This gem adds support of "counter_hash" option for "has_many" associations of ActiveRecord}
  gem.summary       = %q{Support of "counter_hash" option for "has_many" associations of AR}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "cc4has_many"
  gem.require_paths = ["lib"]
  gem.version       = Cc4hasMany::VERSION
end
