require File.dirname(__FILE__) + '/../spec_helper'

describe PeriodsController do
  include PeriodSpecHelper
  
  it_should_behave_like "a RESTfully routed resource"
  
  it_should_behave_like "a default controller (without #show)"
end
