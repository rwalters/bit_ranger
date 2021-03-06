
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bit_ranger/version"

Gem::Specification.new do |spec|
  spec.name          = "bit_ranger"
  spec.version       = BitRanger::VERSION
  spec.authors       = ["Ray Walters"]
  spec.email         = ["ray.walters@gmail.com"]

  spec.summary       = %q{Who was that masked bit?}
  spec.description   = %q{Use bitmasks to handle boolean settings or feature flags}
  spec.homepage      = "https://github.com/rwalters/bit_ranger"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-given", "~> 3.8"
end
