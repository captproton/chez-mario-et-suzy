# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'spec'
require 'spec/rails'

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

  # == Fixtures
  #
  # You can declare fixtures for each example_group like this:
  #   describe "...." do
  #     fixtures :table_a, :table_b
  #
  # Alternatively, if you prefer to declare them only once, you can
  # do so right here. Just uncomment the next line and replace the fixture
  # names with your fixtures.
  #
  # config.global_fixtures = :table_a, :table_b
  #
  # If you declare global fixtures, be aware that they will be declared
  # for all of your examples, even those that don't use them.
  #
  # == Mock Framework
  #
  # RSpec uses it's own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
end

## SHARED EXAMPLES ##

# Specs for invalid model instances
shared_examples_for "invalid model instance" do
  it "should not be valid" do
    @model_instance.should_not be_valid
  end
  
  it "should not return true on #save" do
    @model_instance.save.should_not be_true
  end
  
  it "should complain on #save!" do
    lambda { @model_instance.save! }.should raise_error
  end
end

# Shared examples for valid model instance
shared_examples_for "valid model instance" do
  it "should be valid and have no errors" do
    @model_instance.should be_valid
    @model_instance.errors.should be_empty
  end
  
  it "should return true on #save" do
    @model_instance.save.should be_true
  end
  
  it "should not complain on #save!" do
    lambda { @model_instance.save! }.should_not raise_error
  end
end
