# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'magnet-uri'

Gem::Specification.new do |s|
  s.name        = 'magnet-uri'
  s.version     = MagnetURI::VERSION
  s.platform    = Gem::Platform::RUBY
  s.date        = Time.now
  s.summary     = 'Parser of the Magnet URI scheme'
  s.description = 'A simple library to parse Magnet URI schemes common on BitTorrent sites'
  s.authors     = ['Maurice Nonnekes']
  s.email       = 'maurice@codeninja.nl'
  s.homepage    = 'http://rubygems.org/gems/magnet-uri'

  s.files        = Dir.glob("lib/**/*") + %w(LICENSE README.markdown)
  s.require_path = 'lib'
end
