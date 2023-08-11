
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "docker_wrapper/version"

Gem::Specification.new do |spec|
  spec.name          = "docker_wrapper"
  spec.version       = DockerWrapper::VERSION
  spec.authors       = ["Michelle Brinker"]
  spec.email         = ["megaerafury@hotmail.com"]

  spec.summary       = %q{Wraps the docker command utility in a class}
  spec.homepage      = "https://github.com/michbrinker/docker_wrapper"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.4.1"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.12.0"
  spec.add_development_dependency "open3"
end
