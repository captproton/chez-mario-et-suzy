require File.dirname(__FILE__) + '/../spec_helper'

describe RecipeCategoriesController do
  include RecipeCategorySpecHelper
  
  it_should_behave_like "a RESTfully routed resource"
  
  it_should_behave_like "a default controller (without #show)"
  
  describe "handling DELETE to base_path/1 with unsuccessful destroy" do
    before(:each) do
      @recipe_category = mock_model(RecipeCategory, :destroy => false)
      RecipeCategory.stub!(:find).and_return(@recipe_category)
      
      # New record for redirection
      @new_model_for_redirect = mock_model(RecipeCategory, :new_record? => true)
      RecipeCategory.stub!(:new).and_return(@new_model_for_redirect)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the record requested" do
      RecipeCategory.should_receive(:find).with("1").and_return(@recipe_category)
      do_delete
    end
  
    it "should call destroy on the found record" do
      @recipe_category.should_receive(:destroy).and_return(false)
      do_delete
    end
  
    it "should redirect to the records list" do
      do_delete
      response.should redirect_to(recipe_categories_url)
    end
  end
end
