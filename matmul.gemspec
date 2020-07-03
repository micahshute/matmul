require_relative 'lib/matmul/version'

Gem::Specification.new do |spec|
  spec.name          = "matmul"
  spec.version       = Matmul::VERSION
  spec.authors       = ["Micah Shute"]
  spec.email         = ["micah.shute@gmail.com"]

  spec.summary       = %q{Monkeypatches ruby's Matrix class to enable fast multiplication}
  spec.description   = %q{Allows use of the Strassen strategy or multithreading.}
  spec.homepage      = "https://www.github.com/micahshute/matmul"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
