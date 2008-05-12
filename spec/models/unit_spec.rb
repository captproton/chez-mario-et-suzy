require File.dirname(__FILE__) + '/../spec_helper'

describe Unit do
  include DefaultModelHelper
  include UnitSpecHelper
  
  it_should_behave_like "validates required fields"
  
  it_should_behave_like "find existing records"
end
