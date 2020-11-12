# require all files so they can talk to each other 

require 'bundler'
Bundler.require 

require_relative './lib/api'
require_relative './lib/cli'
require_relative './lib/tarotcards'
require_relative './lib/reading'
require_relative './lib/art'
