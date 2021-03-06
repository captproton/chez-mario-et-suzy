# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'spec'
require 'spec/rails'

# spec_helpers tree structure and some specs in it are inspired from Blerb
# see http://github.com/hornbeck/blerb-core/tree/master
dir = File.dirname(__FILE__)
require "#{dir}/spec_helpers/core"
require "#{dir}/spec_helpers/app_specific"
require "#{dir}/spec_helpers/shared_behaviors"
require "#{dir}/spec_helpers/custom_matchers"

Spec::Runner.configure do |config|
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
end
