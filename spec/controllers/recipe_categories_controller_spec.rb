require File.dirname(__FILE__) + '/../spec_helper'

describe RecipeCategoriesController do
  include RecipeCategorySpecHelper
  
  it_should_behave_like "a RESTfully routed resource"
  
  it_should_behave_like "a default controller (without #show)"
end
