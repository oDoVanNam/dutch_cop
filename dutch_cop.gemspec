# frozen_string_literal: true

require_relative 'lib/rubocop/dutch_cop/version'

Gem::Specification.new do |spec|
  spec.name = 'dutch_cop'
  spec.version = Rubocop::DutchCop::VERSION
  spec.authors = ['oDoVanNam']
  spec.email = ['do.van.nam@sun-asterisk.com']

  spec.summary = 'Custom rubocop for personal use'
  spec.description = 'Dutch Cops is set of custom rubocop rules for personal use.'
  spec.homepage = 'https://github.com/oDoVanNam/dutch_cop'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.require_paths = ['lib']
  spec.files = Dir[
    '{config,lib}/**/*',
    '*.md',
    '*.gemspec',
    'Gemfile',
  ]

  spec.add_runtime_dependency 'rubocop', '~> 1.23'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
