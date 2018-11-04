# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "av_components/version"

Gem::Specification.new do |spec|
  spec.name          = "av_components"
  spec.version       = AvComponents::VERSION
  spec.authors       = ["An Vo"]
  spec.email         = ["thien.an.vo.nguyen@gmail.com"]

  spec.summary       = 'Collection of common components used in projects'
  spec.description   = 'This aim to satisfy my laziness, for my specific cases, so if you want to use, feel free, but no warranty'
  spec.homepage      = "https://github.com/anvox/av_components"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_runtime_dependency "rails"
  spec.add_runtime_dependency "request_store"
end
