# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'rufinol/version'

Gem::Specification.new do |s|
  s.name         = "rufinol"
  s.version      = Rufinol::VERSION
  s.authors      = ["Nathan Stults"]
  s.email        = "hereiam@sonic.net"
  s.homepage     = "http://github.com/PlasticLizard/rufinol"
  s.summary      = "[summary]"
  s.description  = "[description]"

  s.files = Dir.glob("{lib,spec}/**/*") + %w[LICENSE README.rdoc]
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'

  s.add_dependency "thin"
  s.add_dependency "sinatra"
  s.add_dependency "rufirmata"
  s.add_dependency "eventmachine"
  s.add_dependency "em-websocket"
  s.add_dependency "json"

  s.add_development_dependency 'rspec', '~> 2.1'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'libnotify'
  s.add_development_dependency 'guard-coffeescript'
  s.add_development_dependency 'jasmine'
end
