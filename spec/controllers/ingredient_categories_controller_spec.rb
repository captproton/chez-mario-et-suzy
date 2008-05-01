require File.dirname(__FILE__) + '/../spec_helper'

describe IngredientCategoriesController do
  include IngredientCategorySpecHelper
  
  it_should_behave_like "a RESTfully routed resource"
  
  it_should_behave_like "a default controller (without #show)"
end
