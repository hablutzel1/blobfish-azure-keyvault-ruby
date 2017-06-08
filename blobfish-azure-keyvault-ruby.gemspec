# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "blobfish/keyvault/version"

Gem::Specification.new do |spec|
  spec.name          = "blobfish-azure-keyvault-ruby"
  spec.version       = Blobfish::Keyvault::VERSION
  spec.authors       = ["Jaime Hablutzel"]
  spec.email         = ["hablutzel1@gmail.com"]

  spec.summary       = "Blobfish's Ruby client for Azure Key Vault."
  spec.description   = "Ruby client currently allowing to simplify performing certain operations in Azure Key Vault (getting a certificate and signing)."
  spec.homepage      = "https://github.com/hablutzel1/blobfish-azure-keyvault-ruby"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency 'rest-client'
  spec.add_runtime_dependency 'json'
  spec.add_development_dependency "bundler", "~> 1.15"
end
