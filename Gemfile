source ENV['GEM_SOURCE'] || "https://rubygems.org"

def location_for(place, fake_version = nil)
  if place =~ /^(git:[^#]*)#(.*)/
    [fake_version, { :git => $1, :branch => $2, :require => false }].compact
  elsif place =~ /^file:\/\/(.*)/
    ['>= 0', { :path => File.expand_path($1), :require => false }]
  else
    [place, { :require => false }]
  end
end

gem 'rspec-puppet',              :require => false
gem 'rspec-core',                :require => false
gem 'puppetlabs_spec_helper',    :require => false
gem 'simplecov',                 :require => false
gem 'puppet_facts',              :require => false
gem 'json',                      :require => false
gem 'metadata-json-lint',        :require => false
gem 'codeclimate-test-reporter', :require => false
gem 'bundler-audit'
gem 'activesupport', '~> 4.2.0'
gem 'colorize'
gem 'dotenv', '~> 2.0.0'
gem 'gitlab', '~> 3.6.0'
gem 'weekdays', '~> 1.0.0'
gem 'rubocop'

group :system_tests do
  if beaker_version = ENV['BEAKER_VERSION']
    gem 'beaker', *location_for(beaker_version)
  end
  if beaker_rspec_version = ENV['BEAKER_RSPEC_VERSION']
    gem 'beaker-rspec', *location_for(beaker_rspec_version)
  else
    gem 'beaker-rspec',  :require => false
  end
  gem 'serverspec',    :require => false
  gem 'beaker-puppet_install_helper', '>= 0.4.2', :require => false
end

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion, :require => false
else
  gem 'facter', :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end

# vim:ft=ruby
