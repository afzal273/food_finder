#!/usr/bin/ruby -w

## Food Finder ##
# Launch this from command line to get it started

APP_ROOT = File.dirname(__FILE__)

# require "#{APP_ROOT}/lib/guide"
# require File.join(APP_ROOT, 'lib', 'guide.rb')
# require File.join(APP_ROOT, 'lib', 'guide')

# $: variable, contains an array of all folders that Ruby will look into it

$LOAD_PATH.unshift(File.join(APP_ROOT, 'lib'))

# puts $:.inspect

require 'guide'

guide = Guide.new('restaurants.txt')
guide.launch!
