# Blobfish::Keyvault

This gem allows to sign with a key stored in Azure Key Vault as well as getting a certificate from Azure Key Vault. It manages authentication to Azure Key Vault in a very simple way for the client.

## TODOs

- Evaluate to remove the concept of a certificate and private key classes. 
- Evaluate to fork https://github.com/stuartbarr/azure-key-vault making a major refactor to get a similar API to the one in the official https://github.com/Azure/azure-keyvault-java, or just start from scratch?. Anyway maintain the name of this gem in the 'blobfish' namespace, i.e. 'blobfish-azure-keyvault-ruby' with the 'blobfish-' prefix to avoid eventually clashing with an eventual official gem that could be published by Microsoft.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'blobfish-azure-keyvault-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install blobfish-azure-keyvault-ruby

## Usage

For a demonstration project (in spanish) see https://github.com/hablutzel1/blobfish-azure-keyvault-ruby-demo.