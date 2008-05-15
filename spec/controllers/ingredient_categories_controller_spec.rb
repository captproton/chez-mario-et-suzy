require File.dirname(__FILE__) + '/../spec_helper'

describe IngredientCategoriesController do
  include IngredientCategorySpecHelper
  
  it_should_behave_like "a RESTfully routed resource"
  
  it_should_behave_like "a default controller (without #show), with pagination"
  
  describe "handling DELETE to base_path/1 with unsuccessful destroy" do
    before(:each) do
      @ingredient_category = mock_model(IngredientCategory, :destroy => false)
      IngredientCategory.stub!(:find).and_return(@ingredient_category)
      
      # New record for redirection
      @new_model_for_redirect = mock_model(IngredientCategory, :new_record? => true)
      IngredientCategory.stub!(:new).and_return(@new_model_for_redirect)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the record requested" do
      IngredientCategory.should_receive(:find).with("1").and_return(@ingredient_category)
      do_delete
    end
  
    it "should call destroy on the found record" do
      @ingredient_category.should_receive(:destroy).and_return(false)
      do_delete
    end
  
    it "should redirect to the records list" do
      do_delete
      response.should redirect_to(ingredient_categories_url)
    end
  end
end
